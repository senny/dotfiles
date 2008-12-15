(setq mac-emulate-three-button-mouse nil)

;; aquamacs specific
(when (boundp 'aquamacs-version)
  (one-buffer-one-frame-mode 0))

(vendor 'growl)
