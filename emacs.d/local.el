(setq e-max-javascript-jslint-enabled t)

(defun senny-run-unit-tests ()
  (interactive)
  (let ((default-directory (e-max-project-root)))
    (rspec-compile "spec/unit")))


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
(global-set-key (kbd "M-§") 'senny-run-unit-tests)
(defun senny-change-log-mode-hook ()
  (setq tab-width 4)
  (setq left-margin 4)
  (setq indent-tabs-mode nil))

(add-hook 'change-log-mode-hook 'senny-change-log-mode-hook)
