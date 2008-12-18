;; others
(load "senny/modes/ruby")
(load "senny/modes/shell")
(load "senny/modes/java")
(load "senny/modes/javascript")

;; Yasnippet
(vendor 'yasnippet)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat senny-config-dir "/vendor/yasnippet/snippets"))

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

(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

