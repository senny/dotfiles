;; others
(load "senny/ruby")
(load "senny/shell")


;; Org-Mode
(setq load-path (cons "~/.emacs.d/vendor/org-mode/lisp" load-path))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

; magit
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))
     
; ido
;(ido-mode t)
;(setq ido-enable-flex-matching t)

; mode-compile
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)