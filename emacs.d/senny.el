(add-to-list 'load-path (concat senny-config-dir "/vendor"))

(load "senny/global")
(load "senny/smart_tab")
(load "senny/defun")
(load "senny/modes")
(load "senny/display")
(load "senny/temp_files")
(load "senny/bindings")


(vendor 'magit)
(vendor 'textmate)
(vendor 'pastie)
(vendor 'ruby-mode)
(textmate-mode)
