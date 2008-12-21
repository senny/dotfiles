; js2
(setq js2-auto-indent-flag nil)
(setq js2-bounce-indent-flag t)
(setq js2-enter-indents-newline t)
(setq js2-strict-missing-semi-warning nil)

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; js-shell
(setq javascript-shell-command "johnson")
(autoload 'javascript-shell "javascript-mode" nil t)

(defun js2-execute-buffer () 
  (interactive)
  (shell-command (concat "johnson " (buffer-file-name))))

(add-hook 'js2-mode-hook '(lambda () 
                            (define-key js2-mode-map (kbd "A-r") 'js2-execute-buffer)
                            (define-key js2-mode-map (kbd "A-R") 'js2-execute-line)
                            (yas/minor-mode-on)))