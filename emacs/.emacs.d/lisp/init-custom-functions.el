

;; 定义函数打开配置文件init.el
(defun my-open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 光标停留在在括号中内容时，显示该内容所属的两端匹配的括号(highlight enclosing parens)
(defadvice show-paren-function (around fix-show-paren-function activate)
  (cond ((looking-at-p "\\s(") ad-do-it)
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     ad-do-it))))
;; 下面这种写法 emacs24 的版本可能不支持
;; (define-advice show-paren-function (:around (fn) fix-show-paren-function)
;;   (cond ((looking-at-p "\\s(") (funcall fn))
;;   	(t (save-excursion
;;   	     (ignore-errors (backward-up-list))
;;   	     (funcall (fn))))))

;;-----保存所有buffer时不再询问-----
;; Ctrl-Shift-s以及C-x s保存所有buffer，并且不询问
(defun save-all () (interactive) (save-some-buffers t))
(global-set-key (kbd "C-S") 'save-all)
(global-set-key (kbd "C-x s") 'save-all) ;; C-x s是自带的，但是要询问，这样将其变为不询问

;; ------------缩进的配置------------
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indented selected region."))
      (progn
	(indent-buffer)
	(message "Indented buffer.")))))

;; ---------隐藏/删除DOS换行符-----------
;; 隐藏DOS换行符"^M"
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; 删除DOS换行符"^M"
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))


;; ---------occur-mode配置---------------
;; 功能：自动抓取光标所在的单词，对该单词做"occur"操作
;; dwin = do what i mean
(defun my-occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))




(provide 'init-custom-functions)










