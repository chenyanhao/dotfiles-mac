




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
				 company-c-headers
				 monokai-theme
				 spacemacs-theme
				 hungry-delete
				 ;; swiper ;; shows an overview during regex searching
				 counsel ;; needed for swiper
				 smartparens ;; 括号自动补全
				 helm-gtags
				 helm-ag
				 sr-speedbar
				 
				 ;; 前端开发插件
				 js2-mode
				 nodejs-repl
				 web-mode
				 js2-refactor
				 
				 ;; c/c++
				 ggtags
				 company-ycmd

				 exec-path-from-shell ;; 针对mac，让mac系统下面的命令行程序可见
				 popwin
				 reveal-in-osx-finder ;; 针对Mac，可以在finder中打开当前文件
				 iedit ;; 同时编辑多个区域
				 auto-yasnippet ;; 模板插件
				 org-pomodoro
				 flycheck
				 flycheck-pos-tip
				 flymake

				 sr-speedbar
				 
				 evil 
				 evil-leader
				 evil-surround
				 evil-nerd-commenter
				 evil-matchit
				 
				 window-numbering
				 expand-region
				 which-key
				 use-package
				 markdown-mode
				 ;; gh-md
				 neotree
				 ;; all-the-icons
				 magit
				 git-gutter
				 ;; git-commit
				 move-text
				 ;; cmake-mode
				 ;; disaster ;; 查看C/C++的汇编代码
				 ;; semantic-refactor
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
;;(load-theme 'monokai t)
(load-theme 'spacemacs-dark t)

(require 'hungry-delete)
(global-hungry-delete-mode)

;; window-numbering和powerline冲突，即如果有powerline，不会显示window编号
(window-numbering-mode 1)


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


(require 'ycmd)
;; (add-hook 'c++-mode-hook 'company-mode)
;; (add-hook 'c++-mode-hook 'ycmd-mode)
(add-hook 'after-init-hook #'global-ycmd-mode)
(set-variable 'ycmd-server-command '("python" "/Users/yj/.ycmd/ycmd/ycmd"))
;; (set-variable 'ycmd-global-config "/path/to/.ycm_extra_conf.py")
(require 'company-ycmd)
(company-ycmd-setup)


(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

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


;; ================== web-mode 和 js2-mode ====================
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode)
	 )
       auto-mode-alist))
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

;; 交替执行这个函数，缩进会交替变成2个空格/4个空格
(defun my-toggle-web-indent ()
  (interactive)
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))
  (if (eq major-mode 'web-mode)
      (progn
	(setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	(setq  web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	(setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))
  (setq indent-tabs-mode nil))

(add-hook 'js2-mode #'js2-refactor-mode)
;; (js2r-add-keybindings-with-prefix "C-c C-m")

;; --------------------------------------------------


;; ================== sr-speedbar ====================

(setq sr-speedbar-auto-refresh t)
(setq sr-speedbar-right-side nil)

;; --------------------------------------------------


;; ================== ggtags ====================

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))


;; --------------------------------------------------



;; ================== counsel-imenu 增强 ====================
;; (defun js2-imenu-make-index ()
;;       (interactive)
;;       (save-excursion
;; 	;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
;; 	(imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
;; 				   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
;; 				   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
;; 				   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
;; 				   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
;; 				   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
;; 				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
;; 				   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
;; 				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
;; 				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
;; 				   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
;; (add-hook 'js2-mode-hook
;; 	      (lambda ()
;; 		(setq imenu-create-index-function 'js2-imenu-make-index)))

;; --------------------------------------------------





;; ;; --------------markdown-mode-----------------
;; (setq markdown-live-preview-delete-export 'delete-on-export)
;; ;; (setq markdown-coding-system 'utf-8)

;; ;; ----------------neotree----------------------------
;; ;; (require 'all-the-icons)
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)
;; ;; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; ;; -----------flycheck-after-tip-----------------
;; (with-eval-after-load 'flycheck
;;   (flycheck-pos-tip-mode))

;; ;; -----------ecb:Emacs Code Browser-----------------
;; (require 'ecb)
;; (global-set-key (kbd "<f7>") 'ecb-minor-mode)   ; 打开ecb
;; (global-set-key (kbd "C-<left>") 'windmove-left)   ;左边窗口
;; (global-set-key (kbd "C-<right>") 'windmove-right)  ;右边窗口
;; (global-set-key (kbd "C-<up>") 'windmove-up)     ; 上边窗口
;; (global-set-key (kbd "C-<down>") 'windmove-down)   ; 下边窗口

;; (require 'disaster)
;; ;; (define-key c-mode-base-map (kbd "C-c d") 'disaster)
;; (global-set-key (kbd "C-c d") 'disaster) 





(provide 'init-packages)
