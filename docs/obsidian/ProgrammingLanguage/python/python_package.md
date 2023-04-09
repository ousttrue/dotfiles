---
aliases: [setup.py, pyproject.toml]
---

[[python]]

- [Building and Distributing Packages with Setuptools - setuptools 65.5.1.post20221111 documentation](https://setuptools.pypa.io/en/latest/userguide/index.html)
- @2018  [pythonのsetup.pyについてまとめる - Qiita](https://qiita.com/Tadahiro_Yamamura/items/2cbcd272a96bb3761cc8)

# pyproject.toml
- @2015 [PEP 517 – A build-system independent format for source trees | peps.python.org](https://peps.python.org/pep-0517/)
- @2016 [PEP 518 – Specifying Minimum Build System Requirements for Python Projects | peps.python.org](https://peps.python.org/pep-0518/)

## build backend
### setuptools
  - [Build System Support - setuptools 65.5.1.post20221111 documentation](https://setuptools.pypa.io/en/latest/build_meta.html)
```
pyproject.toml
setup.cfg
MODULE_NAME/
	__init__.py
```

pyproject.toml
- [Configuring setuptools using pyproject.toml files - setuptools 65.5.1.post20221111 documentation](https://setuptools.pypa.io/en/latest/userguide/pyproject_config.html)
```toml
[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"  
```

setup.cfg
- [Configuring setuptools using setup.cfg files - setuptools 65.5.1.post20221111 documentation](https://setuptools.pypa.io/en/latest/userguide/declarative_config.html#declarative-config)
```setup.cfg
[metadata]
name = meowpkg
version = 0.0.1
description = a package that meows

[options]
packages = find:
```

entrypoint
- [Entry Points - setuptools 65.5.1.post20221111 documentation](https://setuptools.pypa.io/en/latest/userguide/entry_point.html)

# classifiers
- [分類 · PyPI](https://pypi.org/classifiers/)

# metadata
## setup.py

## setup.cfg
- [Configuring setuptools using setup.cfg files - setuptools 65.6.0.post20221119 documentation](https://setuptools.pypa.io/en/latest/userguide/declarative_config.html)

## pyproject.toml

# extras_require
- [パッケージの依存を分割して pip install する - Qiita](https://qiita.com/tshimura/items/87fadea8123219e2933c)
