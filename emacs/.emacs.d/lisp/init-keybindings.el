
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function) ;; 跳到函数定义
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-c f") 'counsel-git)
(global-set-key (kbd "C-c t") 'counsel-git-grep)
;; (global-set-key (kbd "C-c p f") 'counsel-git)
(global-set-key (kbd "M-s m") 'counsel-imenu)

(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "M-s o") 'my-occur-dwim)

(global-set-key (kbd "C-x k") 'kill-buffer)


(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-set-key (kbd "C-c s o") 'sr-speedbar-open)
(global-set-key (kbd "C-c s c") 'sr-speedbar-close)

;; 注意和 C-h f/v/k 的区别，它们是describe function/variable/key，
;; 而这里是 find function/variable/key
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)


;; ggtags
(global-set-key (kbd "C-c g s") 'ggtags-find-other-symbol)
(global-set-key (kbd "C-c g h") 'ggtags-view-tag-history)
(global-set-key (kbd "C-c g r") 'ggtags-find-reference)
(global-set-key (kbd "C-c g f") 'ggtags-find-file)
(global-set-key (kbd "C-c g c") 'ggtags-create-tags)
(global-set-key (kbd "C-c g u") 'ggtags-update-tags)
(global-set-key (kbd "M-,") 'pop-tag-mark)





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

;; list-buffers
(global-set-key (kbd "C-x C-b") 'list-buffers)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)



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





(provide 'init-keybindings)


(global-set-key (kbd "<f2>") 'my-open-init-file)

(global-set-key (kbd "s-/") 'hippie-expand)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)


;; 注意和 C-h f/v/k 的区别，它们是describe function/variable/key，
;; 而这里是 find function/variable/key
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)


(with-eval-after-load 'dired  ;;dired-mode-map必须要在Dired-Mode进入后才有效，所以这里加这句
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))


;; -----------直接用Ctrl+TAB切换Buffer------------
;; -----默认切换Buffer是"C-x b"，较繁琐，改为C-TAB提高效率--------
(global-set-key (kbd "C-<tab>") #'(lambda ()
				    (interactive)
				    (switch-to-buffer (other-buffer (current-buffer) 1))))



(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)



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





(global-set-key (kbd "C-c a") 'org-agenda)



;; evil模式下可以使用C-u的设置
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))
(evil-leader/set-leader "SPC") ;; 将空格键设置为leader-key
(evil-leader/set-key
  
  ;; "<left>" 'previous-bffer 
  "ff" 'find-file
  "fr" 'recentf-open-files
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "pf" 'counsel-git ;; git项目下文件名搜索
  "pt" 'counsel-git-grep ;; git项目下全文搜索
  "ps" 'helm-do-ag-project-root ;; project-search
  
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
  "wm" 'delete-other-windows ;; 相当于emacs下"C-x 1"
  
  "xf" 'counsel-find-file
  "xr" 'recentf-open-files

  "so" 'sr-speedbar-open
  "sc" 'sr-speedbar-close

  ":" 'counsel-M-x
  )

(global-set-key (kbd "C-=") 'er/expand-region)

(provide 'init-keybindings)
