(add-to-list 'load-path "~/.emacs.d/vendor")

; custom place to save customizations
(setq custom-file "~/.emacs.d/senny/custom.el")
(load custom-file)

(load "senny/global")
(load "senny/smart_tab")
(load "senny/defun")
(load "senny/bindings")
(load "senny/modes")
(load "senny/theme")
(load "senny/temp_files")
(load "senny/git")

(vendor 'magit)
(vendor 'textmate)
(vendor 'growl)
(vendor 'pastie)
(textmate-mode)