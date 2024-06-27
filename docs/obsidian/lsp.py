import logging
import re

from lsprotocol import types

from pygls.server import LanguageServer
from pygls.workspace import TextDocument


class ObsidianLanguageServer(LanguageServer):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # self.index = {}

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
    return types.Location(
        uri=f"{ls.workspace.root_uri}/memo.md",
        range=types.Range(
            types.Position(line=0, character=0),
            types.Position(line=0, character=0),
        ),
    )


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    server.start_io()
