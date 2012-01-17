(setq e-max-repository (expand-file-name "/Users/senny/Projects/e-max/"))

(setq e-max-org-files (expand-file-name "~/Dropbox/org"))

(setq e-max-bundles '(
                      accessibility
                      ergonomic
                      completion
                      css
                      cucumber
                      erlang
                      git
                      html
                      javascript
                      lisp
                      project
                      python
                      power-edit
                      ruby
                      haml-and-sass
                      yaml
                      spelling

                      e-max-developer
                      rails
                      ;; latex
                      org
                      ;; plone
                      ;; terminal
                      ))

;; see https://github.com/senny/theme-roller.el for a list of available themes
(setq e-max-theme 'color-theme-lazy)

(load (concat e-max-repository "e-max"))
