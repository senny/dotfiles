(load (concat senny-config-dir "/vendor/nxhtml/autostart.el"))

(setq
 nxhtml-global-minor-mode t
 mumamo-chunk-coloring 'submode-colored
 nxhtml-skip-welcome t
 indent-region-mode t
 rng-nxml-auto-validate-flag nil
 nxml-degraded t
)

(add-hook 'nxhtml-mode-hook
          '(lambda()
             (define-key nxhtml-mode-map (kbd " ") 'nxml-complete)))

(add-hook 'sgml-mode-hook
          (lambda()
              (defconst sgml-font-lock-keywords-senny
                `((,(concat "<\\([!?]" sgml-name-re "\\)") 1 font-lock-keyword-face)
                  (,(concat "<\\(/?" sgml-namespace-re "\\)\\(?::\\(" sgml-name-re "\\)\\)?")
                   (1 (if (match-end 2) sgml-namespace-face font-lock-keyword-face))
                   (2 font-lock-keyword-face nil t))
                  (,(concat "\\(?:^\\|[ \t]\\)\\(" sgml-namespace-re "\\)\\(?::\\("
                            sgml-name-re "\\)\\)?=[\"']")
                   (1 (if (match-end 2) sgml-namespace-face font-lock-variable-name-face))
                   (2 font-lock-variable-name-face nil t))
                  (,(concat "[&%]" sgml-name-re ";?") . font-lock-variable-name-face)))
             (set (make-local-variable 'font-lock-defaults)
                  '((sgml-font-lock-keywords
                     sgml-font-lock-keywords-1
                     sgml-font-lock-keywords-2
                     sgml-font-lock-keywords-senny)
                    nil t nil nil
                    (font-lock-syntactic-keywords
                    . sgml-font-lock-syntactic-keywords)))
             (font-lock-add-keywords nil
                        '(("<\\|>" . font-lock-keyword-face)))))