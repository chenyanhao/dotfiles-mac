
(package-initialize)


;; ===========================操作系统及emacs版本==============================
(setq *mac* (eq system-type 'darwin))
(setq *win* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'gnu/kfreebsd) (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 24))))




(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'init-packages)
(require 'init-custom-functions)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'init-org)


;; 将 custom-set-variables 放在文件 custom.el 中
(setq custom-file (expand-file-name "~/.emacs.d/lisp/custom.el" user-emacs-directory))
(load-file custom-file) ;; 这句话不可少，不然 custom.el 不会加载









