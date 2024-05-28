import zipfile
import logging
import pathlib
from PySide6 import QtWidgets, QtCore


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
