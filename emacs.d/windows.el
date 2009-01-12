; custom place to save customizations
(setq custom-file (concat senny-config-dir "/senny/windows/custom.el"))
(load custom-file)

; use dos-encoding in windows environments
(set-default-coding-systems 'iso-latin-1-dos)


(setq default-frame-alist '((font . "-outline-Monaco-normal-r-normal-normal-13-112-96-96-c-*-iso8859-1")))

(load "senny")

;use replace the dos environment with cygwin
;(setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
;(setq exec-path (cons "c:/cygwin/bin/" exec-path))
;(vendor 'cygwin-mount)
;(cygwin-mount-activate)

(vendor 'clearcase)
;(add-to-list 'load-path (concat senny-config-dir "/vendor/vc-clearcase"))
;(load "vc-clearcase-auto")
