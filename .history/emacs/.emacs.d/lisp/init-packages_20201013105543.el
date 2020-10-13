




;; ===========================包管理==============================
(when *emacs24*
  (require 'package)
  (package-initialize)

  (setq package-archives '(("gnu" . "https://elpa.emacs-china.org/gnu/")
			   ("melpa" . "https://elpa.emacs-china.org/melpa/")))
  ;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/" ) t)
  ;;(add-to-list 'package-archives '("melpa" . "https://elpa.emacs-china.org/melpa/") t)
  
  )

(require 'cl) ;; require commom-lisp 库

(defvar chenbanxian/packages '(
				 company
				 ;; monokai-theme
				 spacemacs-theme
				 hungry-delete
				 ivy ;; 补全框架
				 swiper ;; shows an overview during regex searching
				 counsel ;; needed for swiper
				 smartparens ;; 括号自动补全

				 spaceline ;; spacemacs's mode-line theme，该 package 会自动会安装其依赖 powerline

				 exec-path-from-shell ;; 针对mac，让mac系统下面的命令行程序可见
				 popwin ;; temporary buffers will be shown as a popup window, and it can be closed by C-g in anytime
				 reveal-in-osx-finder ;; 针对Mac，可以在finder中打开当前文件
				 iedit ;; 同时编辑多个区域
				 org-pomodoro

				 evil 
				 evil-leader
				 evil-surround
				 evil-nerd-commenter
				 evil-matchit
				 
				 all-the-icons ;; 图标库，all-the-icons 默认主题
				 ;; spaceline-all-the-icons ;; 图标库，spaceline 主题
				 all-the-icons-dired ;; dired-mode 也使用 all-the-icons 主题
				 all-the-icons-ivy ;; ivy-mode 也使用 all-the-icons 主题

				 ;; projectile ;; project management and navigation, provide features operating on a project level 
				 treemacs ;; 树形文件浏览器
				 treemacs-all-the-icons ;; treemacs 使用 all-the-icons 主题
				 treemacs-evil ;; If you use evil don’t forget to install 
				 ;; treemacs-icons-dired ;; dired-mode 使用 treemacs 图标主题。all-the-icon-dired 需要下载字体，时间教长，不方便的话可以直接使用该 package


				 window-numbering
				 expand-region
				 which-key
				 use-package
				 magit
				 move-text ;; move current line or region using M-up / M-down 
				 ;; disaster ;; 查看C/C++的汇编代码
				 ) "Default packages")

(setq package-selected-packages chenbanxian/packages)


(defun chenbanxian/packages-installed-p ()
  (loop for pkg in chenbanxian/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))
(unless (chenbanxian/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg chenbanxian/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))
;;==========================================================



;;==========================插件配置================================
;; 应用主题
;; (load-theme 'monokai t)
(load-theme 'spacemacs-dark t)
(require 'spaceline-config)
(spaceline-spacemacs-theme)


;; all-the-icons 相关配置
(require 'all-the-icons) ;; all-the-icons
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode) ;; all-the-icons-dired
(all-the-icons-ivy-setup) ;; all-the-icons-ivy 


;; treemacs 相关配置
(require 'treemacs)
(define-key treemacs-mode-map [mouse-1] 'treemacs-single-click-expand-action) ;; 允许鼠标操作，左键单击
(define-key treemacs-mode-map [mouse-3] 'treemacs-rightclick-menu) ;; 允许鼠标操作，右键打开操作菜单
;; (treemacs-icons-dired-mode t)



(require 'hungry-delete)
(global-hungry-delete-mode)

;; window-numbering和powerline冲突，即如果有powerline，不会显示window编号
(window-numbering-mode 1)


;; ivy fuzzy match
(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))

;; swiper/counsel配置
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)


;; (require 'smartparens-config)
(smartparens-global-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil) ;; emacs-lisp-mode 下，输入单引号不会触发补全

;; mac专属的一句配置
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;; (when *mac*
;;   (exec-path-from-shell-initialize))

(require 'popwin)
(popwin-mode t)
(setq popwin:popup-window-position (quote right))
(setq popwin:popup-window-width 50)



;; --------evil------------
;; evil
(evil-mode 1)


;; (setcdr evil-insert-state-map nil)
;; (define-key evil-insert-state-map [escape] 'evil-normal-state)

;; evil-leader
(global-evil-leader-mode)


;; evil-surround
(require 'evil-surround)
(global-evil-surround-mode 1)

;; evil-nerd-commenter
(evilnc-default-hotkeys)

;; evil-matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; which-key配置
(which-key-mode 1)
(setq which-key-side-window-location 'right)

;; -----------move-text-----------------
(move-text-default-bindings)


;; company-mode设置为全局
(global-company-mode t)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.0)
(setq company-minimum-prefix-length 1)

(setq company-backends (delete 'company-semantic company-backends))
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(add-to-list 'company-backends 'company-c-headers)





(provide 'init-packages)
