(defun insert-soft-tab ()
  (interactive)
  (insert "  "))

(defun defunkt-indent () 
  (interactive)
  (insert "  "))

(defadvice zap-to-char (after dont-zap-char (arg char))
  "Doesn't include the char - zaps to the char before it (like vim)."
  (insert char)
  (backward-char))
(ad-activate 'zap-to-char)

(defun senny-ido-find-config ()
  (interactive)
  (find-file
   (concat "~/.emacs.d/senny/" (ido-completing-read "Config file: "
                                   (directory-files "~/.emacs.d/senny/" nil "^[^.]")))))

(defun defunkt-ido-find-project ()
  (interactive)
  (find-file
   (concat "~/Projects/" (ido-completing-read "Project: "
                           (directory-files "~/Projects/" nil "^[^.]")))))

(defun senny-goto-config ()
  (interactive)
  (find-file "~/.emacs.d/senny.el"))

;; fix kill-word
(defun defunkt-kill-word (arg)
  "Special version of kill-word which swallows spaces separate from words"
  (interactive "p")

  (let ((whitespace-regexp "\\s-+"))
    (kill-region (point) 
                 (cond 
                  ((looking-at whitespace-regexp) (re-search-forward whitespace-regexp) (point))
                  ((looking-at "\n") (kill-line) (defunkt-kill-word arg))
                  (t (forward-word arg) (point))))))

(defun defunkt-backward-kill-word (arg)
  "Special version of backward-kill-word which swallows spaces separate from words"
  (interactive "p")
  (if (looking-back "\\s-+")
      (kill-region (point) (progn (re-search-backward "\\S-") (forward-char 1) (point)))
    (backward-kill-word arg)))

; set the mode based on the shebang;
; TODO: this sometimes breaks
(defun defunkt-shebang-to-mode ()
  (interactive)
  (let*
      ((bang (buffer-substring (point-min) (prog2 (end-of-line) (point) (move-beginning-of-line 1))))
       (mode (progn
               (string-match "^#!.+[ /]\\(\\w+\\)$" bang)
               (match-string 1 bang)))
       (mode-fn (intern (concat mode "-mode"))))
    (when (functionp mode-fn)
      (funcall mode-fn))))
;(add-hook 'find-file-hook 'defunkt-shebang-to-mode)
;duplicate the current line
(defun defunkt-duplicate-line () 
  (interactive)
    (beginning-of-line)
    (copy-region-as-kill (point) (progn (end-of-line) (point)))
    (textmate-next-line)
    (yank)
    (beginning-of-line)
    (indent-according-to-mode))

; for loading libraries in from the vendor directory
(defun vendor (library)
  (let* ((file (symbol-name library)) 
         (normal (concat senny-config-dir "/vendor/" file)) 
         (suffix (concat normal ".el"))
         (senny (concat senny-config-dir "/senny/" file)))
    (cond 
     ((file-directory-p normal) (add-to-list 'load-path normal) (require library))
     ((file-directory-p suffix) (add-to-list 'load-path suffix) (require library))
     ((file-exists-p suffix) (require library)))
    (when (file-exists-p (concat senny ".el"))
      (load senny))))

(require 'thingatpt)
(defun defunkt-change-num-at-point (fn)
  (let* ((num (string-to-number (thing-at-point 'word)))
         (bounds (bounds-of-thing-at-point 'word)))
    (save-excursion
      (goto-char (car bounds))
      (defunkt-kill-word 1)
      (insert (number-to-string (funcall fn num 1))))))

(defun defunkt-inc-num-at-point ()
  (interactive)
  (defunkt-change-num-at-point '+))

(defun defunkt-dec-num-at-point ()
  (interactive)
  (defunkt-change-num-at-point '-))

(defun url-fetch-into-buffer (url)
  (interactive "sURL:")
  (insert (concat "\n\n" ";; " url "\n"))
  (insert (url-fetch-to-string url)))

(defun url-fetch-to-string (url)
  (with-current-buffer (url-retrieve-synchronously url)
    (beginning-of-buffer)
    (search-forward-regexp "\n\n")
    (delete-region (point-min) (point))
    (buffer-string)))

(defun gist-buffer-confirm ()
  (interactive)
  (when (yes-or-no-p "Are you sure you want to Gist this buffer? ") 
    (gist-region-or-buffer)))

;; from http://platypope.org/blog/2007/8/5/a-compendium-of-awesomeness
;; I-search with initial contents
(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))

(defun compile-senny ()
  (interactive)
  (byte-recompile-directory (concat senny-config-dir "/senny") t t))

(defun compile-vendor ()
  (interactive)
  (byte-recompile-directory (concat senny-config-dir "/vendor") t t))

(defun backward-buffer () (interactive)
  "Switch to previously selected buffer."
  (let* ((list (cdr (buffer-list)))
         (buffer (car list)))
    (while (and (cdr list) (string-match "\\*" (buffer-name buffer)))
      (progn
        (setq list (cdr list))
        (setq buffer (car list))))
    (bury-buffer)
    (switch-to-buffer buffer)))

(defun forward-buffer () (interactive)
  "Opposite of backward-buffer."
  (let* ((list (reverse (buffer-list)))
         (buffer (car list)))
    (while (and (cdr list) (string-match "\\*" (buffer-name buffer)))
      (progn
        (setq list (cdr list))
        (setq buffer (car list))))
    (switch-to-buffer buffer)))
