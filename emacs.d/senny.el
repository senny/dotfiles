(add-to-list 'load-path "~/.emacs.d/vendor")

; custom place to save customizations
(setq custom-file "~/.emacs.d/senny/custom.el")
(load custom-file)

(load "senny/global")
(load "senny/defun")
(load "senny/modes")
(load "senny/theme")
(load "senny/temp_files")


(vendor 'textmate)
(vendor 'growl)
(textmate-mode)