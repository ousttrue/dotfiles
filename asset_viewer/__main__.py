from typing import cast
import logging
import pathlib
import sys
from PySide6 import QtWidgets, QtCore, QtGui


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

        self.dir_tree = QtWidgets.QTreeView()
        self.dir_tree.setHeaderHidden(True)
        self.addDockWidget(
            QtCore.Qt.DockWidgetArea.LeftDockWidgetArea,
            self.add_dock("dir", self.dir_tree),
        )

        self.file_list = QtWidgets.QTreeView()
        self.setCentralWidget(self.file_list)

    def set_root_dir(self, dir: pathlib.Path) -> None:
        LOGGER.info(f"{dir}")
        dir_model = QtWidgets.QFileSystemModel()
        dir_model.setRootPath(str(dir))
        dir_model.setFilter(QtCore.QDir.Dirs | QtCore.QDir.NoDotAndDotDot)
        self.dir_tree.setModel(dir_model)
        self.dir_tree.setRootIndex(dir_model.index(str(dir)))
        for i in range(1, self.dir_tree.header().count()):
            self.dir_tree.header().setSectionHidden(i, True)
        self.dir_tree.selectionModel().selectionChanged.connect(self.on_dir_selected)

        list_model = QtWidgets.QFileSystemModel()
        list_model.setFilter(QtCore.QDir.Files | QtCore.QDir.NoDotAndDotDot)
        self.file_list.setModel(list_model)

        self.dir_tree.setCurrentIndex(dir_model.index(str(dir)))

    def on_dir_selected(
        self, selected: QtCore.QItemSelection, deselected: QtCore.QItemSelection
    ) -> None:
        indices = selected.indexes()
        if len(indices) == 0:
            return
        dir_model = cast(QtWidgets.QFileSystemModel, self.dir_tree.model())
        dir = dir_model.filePath(indices[0])
        LOGGER.debug(dir)

        list_model = cast(QtWidgets.QFileSystemModel, self.file_list.model())
        list_model.setRootPath(dir)

        self.file_list.setRootIndex(list_model.index(dir))

    def add_dock(self, name: str, widget: QtWidgets.QWidget) -> QtWidgets.QDockWidget:
        dock = QtWidgets.QDockWidget(name, self)
        dock.setWidget(widget)
        self.menu_docks.addAction(dock.toggleViewAction())  # type: ignore
        return dock


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
