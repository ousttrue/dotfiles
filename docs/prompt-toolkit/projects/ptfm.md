# ptfm

* <https://gitlab.com/lisael/ptfm>

```diff
 .vscode/launch.json               | 15 +++++++++++++++
 ptfm/builtins/plugin/fs.py        |  4 ++--
 ptfm/builtins/ui/termui/termui.py |  5 ++---
 ptfm/cli.py                       |  2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/.vscode/launch.json b/.vscode/launch.json
new file mode 100644
index 0000000..fe724b1
--- /dev/null
+++ b/.vscode/launch.json
@@ -0,0 +1,15 @@
+{
+    // Use IntelliSense to learn about possible attributes.
+    // Hover to view descriptions of existing attributes.
+    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
+    "version": "0.2.0",
+    "configurations": [
+        {
+            "name": "Python: Module",
+            "type": "python",
+            "request": "launch",
+            "module": "ptfm.cli",
+            "console": "externalTerminal"
+        }
+    ]
+}
\ No newline at end of file
diff --git a/ptfm/builtins/plugin/fs.py b/ptfm/builtins/plugin/fs.py
index 390377e..2d058b7 100644
--- a/ptfm/builtins/plugin/fs.py
+++ b/ptfm/builtins/plugin/fs.py
@@ -6,8 +6,8 @@ import asyncio
 from asyncio import CancelledError
 import logging
 
-import aionotify
-from aionotify import Flags
+# import aionotify
+# from aionotify import Flags
 
 
 from ptfm.event import listen, emit
diff --git a/ptfm/builtins/ui/termui/termui.py b/ptfm/builtins/ui/termui/termui.py
index 680d25a..f8d8451 100644
--- a/ptfm/builtins/ui/termui/termui.py
+++ b/ptfm/builtins/ui/termui/termui.py
@@ -19,7 +19,6 @@ from prompt_toolkit.layout.processors import Processor, Transformation
 from prompt_toolkit.patch_stdout import patch_stdout
 from prompt_toolkit.buffer import Buffer
 from prompt_toolkit.document import Document
-from prompt_toolkit.eventloop import use_asyncio_event_loop
 from prompt_toolkit.widgets import Label
 
 
@@ -255,7 +254,7 @@ class TermUI(UI):
         ])
         layout = Layout(self.split)
         # import ipdb; ipdb.set_trace()
-        use_asyncio_event_loop()
+        # use_asyncio_event_loop()
         self.app = Application(
             key_bindings=self.bindings,
             layout=layout,
@@ -432,7 +431,7 @@ class TermUI(UI):
     def run(self):
         with patch_stdout():
             asyncio.get_event_loop().run_until_complete(
-                self.app.run_async().to_asyncio_future())
+                self.app.run_async())
 
     @command()
     def help(self):
diff --git a/ptfm/cli.py b/ptfm/cli.py
index c526799..c1572c2 100644
--- a/ptfm/cli.py
+++ b/ptfm/cli.py
@@ -61,7 +61,7 @@ def load_ui(ui_def):
 def main(root, kakoune, place, plugins, ui):
     """A simple file manager"""
     from .utils import LOGGING_CONFIG
-    logging.config.dictConfig(LOGGING_CONFIG)
+    # logging.config.dictConfig(LOGGING_CONFIG)
 
     root = Path(root).absolute()
     controler = None
```
