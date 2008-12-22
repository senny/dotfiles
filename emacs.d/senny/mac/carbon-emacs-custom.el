;; customization
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(emulate-mac-swiss-german-keyboard-mode t)
 '(erc-modules (quote (autojoin button completion fill irccontrols match menu netsplit noncommands readonly ring scrolltobottom stamp track)))
 '(jde-complete-insert-method-signature nil t)
 '(jde-jdk (quote ("1.5")) t)
 '(jde-jdk-registry (quote (("1.5" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.5"))) t)
 '(mf-display-padding-height 120)
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