from typing import cast
import logging
import pathlib
import sys
from PySide6 import QtWidgets, QtCore
from .inspector import Inspector
from .dirlist import DirList


LOGGER = logging.getLogger(__name__)


class Window(QtWidgets.QMainWindow):
    def __init__(self):
        super().__init__(None)

        # menu
        self.menubar = self.menuBar()
        self.menubar.setNativeMenuBar(False)

        self.menu_file = self.menubar.addMenu("File")
        # open_action = QtGui.QAction("Open", self)
        # self.menu_file.addAction(open_action)  # type: ignore
        # open_action.triggered.connect(self.open_dialog)

        self.menu_docks = self.menubar.addMenu("Docks")
        self.docks: dict[str, QtWidgets.QDockWidget] = {}

        self.file_list = QtWidgets.QTreeView()
        self.setCentralWidget(self.file_list)

        self.dir_tree = DirList()
        self.dir_tree.dir_selected.connect(self._on_dir_selected)
        self._add_dock(
            QtCore.Qt.DockWidgetArea.LeftDockWidgetArea, "dir", self.dir_tree
        )

        self.inspector = Inspector()
        self._add_dock(
            QtCore.Qt.DockWidgetArea.RightDockWidgetArea, "inspector", self.inspector
        )

    def _add_dock(
        self, area: QtCore.Qt.DockWidgetArea, name: str, widget: QtWidgets.QWidget
    ) -> QtWidgets.QDockWidget:
        dock = QtWidgets.QDockWidget(name, self)
        dock.setWidget(widget)
        self.menu_docks.addAction(dock.toggleViewAction())  # type: ignore
        self.addDockWidget(area, dock)
        self.docks[name] = dock
        return dock

    def set_root_dir(self, dir: pathlib.Path) -> None:
        self.docks["dir"].setWindowTitle(dir.name)
        self.dir_tree.set_root_dir(dir)

        list_model = QtWidgets.QFileSystemModel()
        list_model.setFilter(
            QtCore.QDir.Filter.Files | QtCore.QDir.Filter.NoDotAndDotDot
        )
        list_model.setNameFilters(["*.zip"])
        list_model.setNameFilterDisables(False)

        self.file_list.setModel(list_model)
        self.file_list.selectionModel().selectionChanged.connect(self._on_file_selected)

        self.dir_tree.select(dir)

    def _on_dir_selected(self, dir: str) -> None:
        list_model = cast(QtWidgets.QFileSystemModel, self.file_list.model())
        list_model.setRootPath(dir)
        self.file_list.setRootIndex(list_model.index(dir))

    def _on_file_selected(
        self, selected: QtCore.QItemSelection, deselected: QtCore.QItemSelection
    ) -> None:
        indices = selected.indexes()
        if len(indices) == 0:
            return
        file_model = cast(QtWidgets.QFileSystemModel, self.file_list.model())
        file = pathlib.Path(file_model.filePath(indices[0]))
        self.docks["inspector"].setWindowTitle(file.name)

        self.inspector.set_file(file)


def main(path: pathlib.Path):
    app = QtWidgets.QApplication(sys.argv)
    window = Window()
    window.resize(1024, 768)
    window.show()
    window.set_root_dir(path)
    sys.exit(app.exec())


if __name__ == "__main__":
    logging.basicConfig(
        format="%(name)s [%(levelname)s] %(funcName)s => %(message)s",
        level=logging.DEBUG,
    )
    if len(sys.argv) == 1:
        print(f"usage: {sys.argv[0]} ASSETS_DIR")
        sys.exit(1)
    main(pathlib.Path(sys.argv[1]))
