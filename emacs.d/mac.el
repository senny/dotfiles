; custom place to save customizations
(setq custom-file (concat senny-config-dir "/senny/mac/custom.el"))
(load custom-file)

(setq mac-emulate-three-button-mouse nil)

;; aquamacs specific
(when (boundp 'aquamacs-version)
  (one-buffer-one-frame-mode 0))

(load "senny")

(vendor 'growl)
