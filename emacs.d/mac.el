; custom place to save customizations
(cond
  ((string-match "aquamacs" (version))
    (setq custom-file (concat senny-config-dir "/senny/mac/aquamacs-custom.el"))
  )
  ((string-match "carbon" (version))
    (setq custom-file (concat senny-config-dir "/senny/mac/carbon-emacs-custom.el"))
  ))
(load custom-file)

(set-default-font "-apple-consolas-medium-r-normal--13-130-72-72-m-130-iso10646-1")

(setq mac-emulate-three-button-mouse nil)

;; aquamacs specific
(when (boundp 'aquamacs-version)
  (one-buffer-one-frame-mode 0))

(load "senny")

;(vendor 'growl)