import logging
import re
import pathlib

from lsprotocol import types

from pygls.server import LanguageServer
from pygls.workspace import TextDocument


class ObsidianLanguageServer(LanguageServer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.index: dict[str, pathlib.Path] = {}

    # def parse(self, doc: TextDocument):
    #     typedefs = {}
    #     funcs = {}
    #
    #     for linum, line in enumerate(doc.lines):
    #         if (match := TYPE.match(line)) is not None:
    #             name = match.group(1)
    #             start_char = match.start() + line.find(name)
    #
    #             typedefs[name] = types.Range(
    #                 start=types.Position(line=linum, character=start_char),
    #                 end=types.Position(line=linum, character=start_char + len(name)),
    #             )
    #
    #         elif (match := FUNCTION.match(line)) is not None:
    #             name = match.group(1)
    #             start_char = match.start() + line.find(name)
    #
    #             funcs[name] = types.Range(
    #                 start=types.Position(line=linum, character=start_char),
    #                 end=types.Position(line=linum, character=start_char + len(name)),
    #             )
    #
    #     self.index[doc.uri] = {
    #         "types": typedefs,
    #         "functions": funcs,
    #     }
    #     logging.info("Index: %s", self.index)


server = ObsidianLanguageServer("obsidian-server", "v1")


@server.feature(types.TEXT_DOCUMENT_DID_OPEN)
def did_open(ls: ObsidianLanguageServer, params: types.DidOpenTextDocumentParams):
    """Parse each document when it is opened"""
    if ls.index:
        return

    def traverse(dir: pathlib.Path):
        for child in dir.iterdir():
            if child.is_dir():
                traverse(child)
            elif child.is_file():
                ls.index[child.stem] = child.absolute()

    if ls.workspace.root_path:
        traverse(pathlib.Path(ls.workspace.root_path))

    # doc = .get_text_document(params.text_document.uri)
    # ls.parse(doc)


@server.feature(types.TEXT_DOCUMENT_DEFINITION)
def goto_definition(ls: ObsidianLanguageServer, params: types.DefinitionParams):
    """Jump to an object's definition."""
    doc = ls.workspace.get_text_document(params.text_document.uri)
    # index = ls.index.get(doc.uri)
    # if index is None:
    #     return

    word = doc.word_at_position(params.position)

    # Is word a type?
    # if (range_ := index["types"].get(word, None)) is not None:
    #     return types.Location(uri=doc.uri, range=range_)
    path = ls.index[word]
    if path:
        return types.Location(
            uri=path.as_uri(),
            range=types.Range(
                types.Position(line=0, character=0),
                types.Position(line=0, character=0),
            ),
        )


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    server.start_io()
