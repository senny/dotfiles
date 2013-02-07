(setq cabbage-repository (expand-file-name "/Users/senny/Projects/cabbage/"))

(setq cabbage-org-files (expand-file-name "~/Dropbox/org"))

(setq cabbage-bundles '(
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
                      coffee-script

                      cabbage-developer
                      rails
                      ;; latex
                      org
                      ;; plone
                      ;; terminal
                      less-css
                      ))

;; see https://github.com/senny/theme-roller.el for a list of available themes
(setq cabbage-theme 'color-theme-lazy)

(load (concat cabbage-repository "cabbage"))
(put 'ido-exit-minibuffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
