;; customization
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 151 t)
 '(cua-mode nil nil (cua-base))
 '(emulate-mac-swiss-german-keyboard-mode t)
 '(erc-modules (quote (autojoin button completion fill irccontrols match menu netsplit noncommands readonly ring scrolltobottom stamp track)))
 '(javascript-shell-command "johnson" t)
 '(jde-jdk (quote ("1.5")))
 '(jde-jdk-registry (quote (("1.5" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.5"))))
 '(js2-auto-indent-flag nil t)
 '(js2-bounce-indent-flag t t)
 '(js2-enter-indents-newline t t)
 '(js2-strict-missing-semi-warning nil t)
 '(one-buffer-one-frame-mode nil nil (aquamacs-frame-setup))
 '(scroll-bar-mode nil)
 '(setq x-select-enable-clipboard)
 '(show-paren-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; for compatibility with older Aquamacs versions
 (defvar aquamacs-140-custom-file-upgraded t)
 (unless (fboundp 'auto-detect-longlines) (defun auto-detect-longlines () t))