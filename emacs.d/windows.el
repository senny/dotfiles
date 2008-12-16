; custom place to save customizations
(setq custom-file (concat senny-config-dir "/senny/windows/custom.el"))
(load custom-file)



(setq default-frame-alist '((font . "-outline-Monaco-normal-r-normal-normal-15-112-96-96-c-*-iso8859-1")))

(load "senny")

(defun maximize-frame (&optional frame)
"Maximize the selected FRAME."
(interactive)
(or frame
    (setq frame (selected-frame)))
(let ((pixels-per-col (/ (float (frame-pixel-width))
			 (frame-width)))
      (pixels-per-row (/ (float
			  (frame-pixel-height)) (frame-height))))
  (set-frame-size frame
		  ;; truncate or round?
		  (truncate (/
			     (x-display-pixel-width) pixels-per-col))
		  ;; reduce size to account for the toolbar
		  (- (truncate (/
				(x-display-pixel-height) pixels-per-row)) 7))
  (set-frame-position frame 0 0)))

;; Maximize frame on startup
(if (string= "w32" window-system)
    (w32-send-sys-command 61488)
  (maximize-frame))
