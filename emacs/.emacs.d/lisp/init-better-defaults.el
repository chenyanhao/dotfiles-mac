
;;============================better defaults==============================

;; 透明度设置
;; 其中 100 指定当 Emacs 在使用中时的透明度，而 0 则指定其它应用在使用中时 Emacs 的透明度。
;; (set-frame-parameter nil 'alpha '(100 . 0))

;; 关闭tool-bar和scroll-bar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode t)

;; 复制粘贴的配置
;; To cut the text, press C-w .
;; To copy the text, press M-w .
;; To paste the text, press C-y .
;; 允许粘贴到外部程序
(setq x-select-enable-clipboard t)


;; shell 配置
;; (setq shell-file-name "/bin/zsh")
;; (autoload 'ansi-color-for-comint-mode "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode)


;; 去掉emacs启动后的默认画面
(setq inhibit-splash-screen t)

;; 显示匹配括号
(global-auto-revert-mode t)

;; 显示日期和时间的配置
(display-time-mode 1) ;; minibuffer上显示时间
(setq display-time-24hr-format t)  ;; 时间使用24小时制
(setq display-time-day-and-date t) ;; 包括具体日期和具体时间

;; 设置默认工作目录
(when *win*
  (setq default-directory "E:/Dev-Documents/WS-emacs/"))
(when *mac*
  (setq default-directory "~/Documents/WS-Emacs/"))



;; 设置光标形状
(setq-default cursor-type 'bar)


;; 让一些mode可以使用emacs-state
;; Made some modes to use emacs-state
(dolist (mode '(ag-mode
    ;; xxx-mode
    ;; yyy-mode
    )
        )
  (add-to-list 'evil-emacs-state-modes mode))


;; 设置默认字体
;; 可以通过"M-x describe-fonts"查看当前字体
(when *win*
  (set-default-font "-outline-Ubuntu Mono-normal-normal-normal-momo-16-*-*-*-c-*-iso8859-1"))

;; "最近打开的文件"配置
(recentf-mode t)
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 15)

;; 禁止自动备份和自动保存 (自动保存会生成#filename#这种文件)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; 关闭烦人的错误提示音
(setq ring-bell-function 'ignore)

;; 开启auto-revert-mode，这样当文件在emacs外部被修改的时候，emacs会自动加载磁盘上的文件
(global-auto-revert-mode t)


;; 使emacs和其他编辑器一致
(delete-selection-mode t)

;; 启动emacs就最大化
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 光标在括号处时显示匹配括号
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)


;; 高亮当前行
(global-hl-line-mode t)

;; 设置编码
;; (set-language-environment "UTF-8")

;; emacs询问yes or no改为y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; C-w可以回删一个单词
(global-set-key (kbd "C-w") 'backward-kill-word)

;; 在标题栏提示你目前在什么位置
(setq frame-title-format "emacs@%b")

;; ---------Dired-Mode配置---------------
;; 删除目录时不再询问是否递归删除
(setq dired-recursive-deletes 'always)

;; 拷贝目录时不再询问是否递归拷贝
(setq dired-recursive-copies 'always)

;; 默认的Dired-Mode下打开目录或文件不会重用当前Buffer，而是产生很多Buffer；
;; 所以设置其可以重用当前Buffer
(put 'dired-find-alternate-file 'disabled nil)

;; 可以用快捷键C-x_C-j打开当前文件的Dired-Mode
(require 'dired-x)

;; 更加方便的在不同 dired-buffer 间复制(复制时不需要键入 dest-buffer 的路径)
(setq dired-dwin-target t)

;; setq和setq-default的区别：
;; diff between setq and setq-default
;; setq: changes the "buffer-local" variable
;; setq-default: sets the global default value
;; if a variable is not buffer-local, 
;; the setq and setq-default do the same thing
;; ----------------------------



(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill
					 try-complete-filename-partially
					 try-complete-filename
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
					 try-complete-lisp-symbol))



(provide 'init-better-defaults)



