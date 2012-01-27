(setq e-max-javascript-jslint-enabled t)

(add-hook 'e-max-initialized-hook (lambda ()
                                    (setq rspec-use-bundler-when-possible t)))

(defun senny-tableize-data ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (replace-string "	" "|")
    (beginning-of-buffer)
    (replace-regexp "$" "|")
    (beginning-of-buffer)
    (replace-regexp "^" "|")
    (orgtbl-mode)
    (call-interactively 'orgtbl-tab)))

(global-set-key (kbd "M-<prior>") 'start-kbd-macro)
(global-set-key (kbd "M-<next>") 'end-kbd-macro)

(defun senny-toggle-rspec-use-bundler ()
  (interactive)
  (setq rspec-use-bundler-when-possible
        (not rspec-use-bundler-when-possible)))

(global-set-key (kbd "<f6>") 'senny-toggle-rspec-use-bundler)
