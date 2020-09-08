



;; org-mode嵌入代码的模板配置
;; press "<s" and then "TAB" in org-mode,
;; it will auto generate "BEGIN_SRC emacs-lisp ... END_SRC".
(require 'org)
(setq org-src-fontify-natively t)
(setq org-agenda-files '("~/org"))


(provide 'init-org)
