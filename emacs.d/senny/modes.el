;; others
(load "senny/modes/nxhtml")
(load "senny/modes/ruby")
(load "senny/modes/shell")
(load "senny/modes/java")
(load "senny/modes/javascript")

; use tab to indent and complete
(tabkey2-mode)
(setq tabkey2-completion-functions
     '(("JDE Completion" jde-complete-minibuf)
       ("Spell check word" flyspell-correct-word-before-point)
       ("Yasnippet" yas/expand (yas/expandable-at-point))
       ("Semantic Smart Completion" senator-complete-symbol senator-minor-mode)
       ("Programmable completion" pcomplete)
       ("nXML completion" nxml-complete)
       ("Complete Emacs symbol" lisp-complete-symbol)
       ("Widget complete" widget-complete)
       ("Comint Dynamic Complete" comint-dynamic-complete)
       ("PHP completion" php-complete-function)
       ("Tags completion" complete-symbol)
       ("Predictive word" complete-word-at-point predictive-mode)
       ("Predictive abbreviations" pabbrev-expand-maybe)
       ("Dynamic word expansion" dabbrev-expand nil (setq dabbrev--last-abbrev-location nil))
       ("Ispell complete word" ispell-complete-word)
       ("Anything" anything (commandp 'anything))))

; linum
(require 'linum)
(global-linum-mode 1)

;; Yasnippet
(vendor 'yasnippet)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat senny-config-dir "/vendor/yasnippet/snippets"))
(yas/load-directory (concat senny-config-dir "/senny/snippets"))

;; Org-Mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; magit
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))
     
; ido
(ido-mode t)
(setq ido-enable-flex-matching t)

; mode-compile
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)

(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)
