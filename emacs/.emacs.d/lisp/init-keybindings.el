
;; EMACS 快捷键绑定规范
;; In summary, the general rules are:
;; - C-x reserved for Emacs native essential keybindings: buffer, window, frame, file, directory, etc...
;; - C-c reserved for user and major mode:
;;   * C-c letter reserved for user. <F5>-<F9> reserved for user.
;;   * C-c C-letter reserved for major mode.
;; - Don't rebind C-g, C-h and ESC.


;; 搜索相关
(global-set-key (kbd "C-f") 'swiper) ;; 单文件中grep
(global-set-key (kbd "C-S-f") 'counsel-git-grep) ;; 在一个git项目中grep
(global-unset-key "\C-c\ p") ;; evil-nerd-commenter 插件默认将 C-c p 绑定了，这里要先解绑，不然后面绑定 C-c p f 报错
(global-set-key (kbd "C-c p f") 'counsel-git) ;; 在一个git项目中find-file


(global-set-key (kbd "M-x") 'counsel-M-x)

(global-set-key "\C-c\ \C-r" 'recentf-open-files)

(global-set-key (kbd "M-s o") 'my-occur-dwim)


(global-set-key (kbd "C-c =") 'indent-region-or-buffer)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(global-set-key (kbd "C-c a") 'org-agenda)


(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function) ;; 跳到函数定义
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
;; 注意和 C-h f/v/k 的区别，它们是describe function/variable/key，
;; 而这里是 find function/variable/key
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)



(with-eval-after-load 'dired  ;;dired-mode-map必须要在Dired-Mode进入后才有效，所以这里加这句
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))


;; -----------Ctrl+TAB切换最近的两个Buffer------------
(global-set-key (kbd "C-<tab>") #'(lambda ()
				    (interactive)
				    (switch-to-buffer (other-buffer (current-buffer) 1))))

;; 切换 buffer
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)
;; ignore useless buffers while switching，切换时忽略掉 * 打头的 buffer
(set-frame-parameter (selected-frame) 'buffer-predicate (lambda (buf) (not (string-match-p "^*" (buffer-name buf)))))





;; occur-mode下也可以使用hjkl来移动
(add-hook 'occur-mode-hook
	  (lambda ()
	    (evil-add-hjkl-bindings occur-mode-map 'emacs
	      (kbd "/")       'evil-search-forward
	      (kbd "n")       'evil-search-next
	      (kbd "N")       'evil-search-previous
	      (kbd "C-d")     'evil-scroll-down
	      (kbd "C-u")     'evil-scroll-up
	      )))


;; 让一些mode可以使用emacs-state
;; Made some modes to use emacs-state
(dolist (mode '(ag-mode
		;; xxx-mode
		;; yyy-mode
		)
	      )
  (add-to-list 'evil-emacs-state-modes mode))



;; evil模式下可以使用C-u的设置
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))
(evil-leader/set-leader "SPC") ;; 将空格键设置为leader-key
(evil-leader/set-key
  
  "ff" 'find-file
  "fr" 'recentf-open-files
  "bl" 'list-buffers
  "bs" 'switch-to-buffer
  "bk" 'kill-buffer
  "pf" 'counsel-git ;; git项目下find-file
  "pg" 'counsel-git-grep ;; git项目下grep
  
  ;;------- vim下窗口操作配置-----------
  ;; 切换窗口
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "4" 'select-window-4
  "5" 'select-window-5
  "6" 'select-window-6
  "7" 'select-window-7
  "8" 'select-window-8
  "9" 'select-window-9
  "0" 'select-window-0
  
  "w/" 'split-window-right ;; 右分屏
  "w-" 'split-window-below ;; 下分屏
  "w1" 'delete-other-windows ;; 相当于emacs下"C-x 1"
  
  "xf" 'counsel-find-file

  ":" 'counsel-M-x
  )


(provide 'init-keybindings)
