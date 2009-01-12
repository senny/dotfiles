(defvar *fipo-view-path* "C:\\views\\"
  "Location where the clearcase views are located")
(defvar *fipo-gf-exclude*
  "/\\.|\\.class")

(defvar *fipo-mode-map* (make-sparse-keymap))
(defvar *fipo-project-root* nil)
(defvar *fipo-project-path* nil)

(defun fipo-bind-keys ()
  (define-key *fipo-mode-map* "\C-xv" 'fipo-ido-find-view))

(defun fipo-ido-find-view ()
  (interactive)
  (let* ((view (ido-completing-read "View: "
                                    (directory-files *fipo-view-path* nil "^[^.]")))
         (path-to-view (concat *fipo-view-path* view)))
    (setq *fipo-project-root* path-to-view)
    (setq *fipo-project-path* (concat *fipo-project-root* "\\fipo\\se\\"))
    (find-file *fipo-project-path*)))

(defun fipo-ido-open-view-file ()
  (interactive)
  (when (null *fipo-project-path*)
    (error "No view selected"))
  (find-file (concat *fipo-project-path* 
                     (ido-completing-read (concat *fipo-project-path* ": ")
                                          (fipo-view-files)))))
(defun fipo-view-files ()
  (split-string (shell-command-to-string
   (concat
    "find " *fipo-project-path* " -type f | grep -vE '"
    *fipo-gf-exclude*
    "' | sed 's:"
    *fipo-project-path*
    "/::'"))))

;;;###autoload
  (define-minor-mode fipo-mode "Fipo Minor Mode"
    :global t :lighter " fipo" :keymap *fipo-mode-map*
    (fipo-bind-keys))

  (provide 'fipo)
;;; fipo.el ends here