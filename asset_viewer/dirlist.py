from typing import cast
import logging
import pathlib
from PySide6 import QtWidgets, QtCore


LOGGER = logging.getLogger(__name__)


class DirList(QtWidgets.QWidget):
    dir_selected = QtCore.Signal(str)

    def __init__(self):
        super().__init__()

        layout = QtWidgets.QVBoxLayout()

        self.dir_tree = QtWidgets.QTreeView()
        self.dir_tree.setHeaderHidden(True)
        layout.addWidget(self.dir_tree)

        self.setLayout(layout)

    def set_root_dir(self, dir: pathlib.Path) -> None:
        LOGGER.info(f"{dir}")
        dir_model = QtWidgets.QFileSystemModel()
        dir_model.setRootPath(str(dir))
        dir_model.setFilter(QtCore.QDir.Filter.Dirs | QtCore.QDir.Filter.NoDotAndDotDot)
        self.dir_tree.setModel(dir_model)
        self.dir_tree.setRootIndex(dir_model.index(str(dir)))
        for i in range(1, self.dir_tree.header().count()):
            self.dir_tree.header().setSectionHidden(i, True)
        self.dir_tree.selectionModel().selectionChanged.connect(self._on_dir_selected)

    def select(self, dir: pathlib.Path) -> None:
        dir_model = cast(QtWidgets.QFileSystemModel, self.dir_tree.model())
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

        self.dir_selected.emit(dir)
