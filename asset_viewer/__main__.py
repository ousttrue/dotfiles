from typing import cast
import zipfile
import logging
import pathlib
import sys
from PySide6 import QtWidgets, QtCore, QtGui


LOGGER = logging.getLogger(__name__)


class ArchiveModel(QtCore.QAbstractTableModel):
    def __init__(
        self,
        zf: zipfile.ZipFile,
    ):
        super().__init__()
        self.headers = ["name"]
        self.zf = zf
        self.names = zf.namelist()
        # self.column_from_item = column_from_item
        # self.items = items

    def columnCount(self, parent: QtCore.QModelIndex | QtCore.QPersistentModelIndex) -> int:  # type: ignore
        return len(self.headers)

    def data(self, index: QtCore.QModelIndex | QtCore.QPersistentModelIndex, role: QtCore.Qt.ItemDataRole) -> str | None:  # type: ignore
        if role == QtCore.Qt.DisplayRole:  # type: ignore
            if index.isValid():
                name = index.internalPointer()  # type: ignore
                return name

    def headerData(self, section: int, orientation: QtCore.Qt.Orientation, role: QtCore.Qt.ItemDataRole) -> str | None:  # type: ignore
        match orientation, role:
            case QtCore.Qt.Horizontal, QtCore.Qt.DisplayRole:  # type: ignore
                return self.headers[section]
            case _:
                pass

    def index(  # type: ignore
        self,
        row: int,
        column: int,
        parent: QtCore.QModelIndex | QtCore.QPersistentModelIndex,
    ) -> QtCore.QModelIndex:
        assert not parent.isValid()
        childItem = self.names[row]
        return self.createIndex(row, column, childItem)

    def parent(  # type: ignore
        self,
        child: QtCore.QModelIndex | QtCore.QPersistentModelIndex,
    ) -> QtCore.QModelIndex:
        return QtCore.QModelIndex()

    def rowCount(self, parent: QtCore.QModelIndex | QtCore.QPersistentModelIndex) -> int:  # type: ignore
        return len(self.names)


class Inspector(QtWidgets.QWidget):
    def __init__(self):
        super().__init__(None)
        layout = QtWidgets.QVBoxLayout()

        self.file: pathlib.Path | None = None

        self.encodings = QtWidgets.QListWidget()
        self.encodings.addItems(
            [
                "utf-8",
                "cp932",
                "GB18030",
            ]
        )
        layout.addWidget(self.encodings)
        self.encodings.setCurrentRow(0)
        self.encodings.itemSelectionChanged.connect(self._on_encoding)

        self.zip_list = QtWidgets.QTreeView()
        layout.addWidget(self.zip_list)

        # rename

        # move

        self.setLayout(layout)

    def set_file(self, file: pathlib.Path):
        match file.suffix:
            case ".zip":
                encoding = self.encodings.currentItem().text()
                self._set_file_encoding(file, encoding)

            case _:
                LOGGER.info(file)

    def _set_file_encoding(self, file: pathlib.Path, encoding: str) -> None:
        self.file = file
        try:
            zf = zipfile.ZipFile(file, metadata_encoding=encoding)
            model = ArchiveModel(zf)
            self.zip_list.setModel(model)
        except UnicodeDecodeError as ex:
            LOGGER.error(ex)

    def _on_encoding(self):
        if not self.file:
            return
        encoding = self.encodings.currentItem().text()
        self._set_file_encoding(self.file, encoding)


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

        self.dir_tree = QtWidgets.QTreeView()
        self.dir_tree.setHeaderHidden(True)
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
        LOGGER.info(f"{dir}")
        self.docks["dir"].setWindowTitle(dir.name)

        dir_model = QtWidgets.QFileSystemModel()
        dir_model.setRootPath(str(dir))
        dir_model.setFilter(QtCore.QDir.Dirs | QtCore.QDir.NoDotAndDotDot)
        self.dir_tree.setModel(dir_model)
        self.dir_tree.setRootIndex(dir_model.index(str(dir)))
        for i in range(1, self.dir_tree.header().count()):
            self.dir_tree.header().setSectionHidden(i, True)
        self.dir_tree.selectionModel().selectionChanged.connect(self._on_dir_selected)

        list_model = QtWidgets.QFileSystemModel()
        list_model.setFilter(QtCore.QDir.Files | QtCore.QDir.NoDotAndDotDot)
        self.file_list.setModel(list_model)
        self.file_list.selectionModel().selectionChanged.connect(self._on_file_selected)

        self.dir_tree.setCurrentIndex(dir_model.index(str(dir)))

    def _on_dir_selected(
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
