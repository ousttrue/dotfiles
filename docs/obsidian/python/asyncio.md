---
aliases: [pygls]
---

[[python]]

- [asyncio --- 非同期 I/O — Python 3.11.0b5 ドキュメント](https://docs.python.org/ja/3/library/asyncio.html)

# lspprotocol
- [GitHub - microsoft/lsprotocol: Python implementation of the Language Server Protocol.](https://github.com/microsoft/lsprotocol)

# asyncio.protocol
- [トランスポートとプロトコル — Python 3.11.0b5 ドキュメント](https://docs.python.org/ja/3/library/asyncio-protocol.html)

## pygls
[[lsp]]

### pygls.protocol.JsonRpcProtocol
```python
        self.fm = FeatureManager(server)
```

### pygls.protocol.LanguageServerProtocol

### pygls.server.LanguageServer
- workspace management
```python
    @lsp_method(TEXT_DOCUMENT_DID_OPEN)

    def lsp_text_document__did_open(self, params: DidOpenTextDocumentParams) -> None:

        """Puts document to the workspace."""

        self.workspace.put_document(params.text_document)

    def get_document(self, doc_uri: str) -> Document:
		pass
```
- user
```python
def _validate(ls: LanguageServer, params):
    ls.show_message_log("Validating json...")
    text_doc = ls.workspace.get_document(params.text_document.uri)
```

## Subprocesses
- [Subprocesses — Python 3.10.2 documentation](https://docs.python.org/3/library/asyncio-subprocess.html)
