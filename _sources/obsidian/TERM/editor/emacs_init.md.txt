# symlink
- [Emacs and symbolic links - Stack Overflow](https://stackoverflow.com/questions/15390178/emacs-and-symbolic-links)
- [Emacs で勝手に vc-follow-link が実行されて辛い - あらびき日記](https://abicky.net/2014/06/07/175130/)

```lisp
(setq vc-handled-backends nil)

;; unlock warn
;;(setq vc-follow-symlinks t)
;;(setq vc-follow-symlinks nil)
```
