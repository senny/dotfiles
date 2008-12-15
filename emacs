(setq senny-config-dir "~/projects/dotfiles/emacs.d")
(add-to-list 'load-path senny-config-dir)

(cond 
  ((string-match "nt5" system-configuration) 
   (load "windows")
  )
  ((string-match "mac" system-configuration)
    (load "mac")
  ))

(if (file-exists-p (concat senny-config-dir "/local.el")) (load "local") )
