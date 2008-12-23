;; disable toolbar
(when (functionp 'tool-bar-mode)
  (tool-bar-mode nil))

;; start maximized
(vendor 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; highlight
(show-paren-mode t)

;; Use a vertical bar as cursor
(blink-cursor-mode t)
(setq-default cursor-type '(bar . 2))


(require 'color-theme)
(when (fboundp 'color-theme-initialize)
  (color-theme-initialize))
(setq color-theme-is-global t)

(load-file (concat senny-config-dir "/senny/color-theme-twilight.el"))
(load-file (concat senny-config-dir "/senny/color-theme-github.el"))
(color-theme-twilight)

; how to get the font you want:
;   M-x mac-font-panel
;   pick your font
;   M-x describe-font
; (setq default-frame-alist '((font . "-apple-inconsolata-medium-r-normal--16-160-72-72-m-160-iso10646-1")))
