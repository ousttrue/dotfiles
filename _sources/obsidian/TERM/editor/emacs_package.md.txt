[[emacs]]
- [Emacsモダン化計画 -かわEmacs編- - Qiita](https://qiita.com/Ladicle/items/feb5f9dce9adf89652cf)

# initialize
```lisp
(setq package-user-dir "~/.emacs.d/elisp/elpa/")
(setq package-archives
      '(("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org"   . "http://orgmode.org/elpa/")))
(package-initialize)
;;
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-enable-imenu-support t)
(setq use-package-always-ensure t)
(require 'use-package)
```

# use-package
