;; Twilight Colour Theme for Emacs.
;;
;; Defines a colour scheme resembling that of the original TextMate Twilight colour theme.
;; To use add the following to your .emacs file (requires the color-theme package):
;;
;; (require 'color-theme)
;; (color-theme-initialize)
;; (load-file "~/.emacs.d/twilight-emacs/color-theme-twilight.el")
;;
;; And then (color-theme-twilight) to activate it.
;;
;; Several areas still require improvement such as recognition of code that ruby-mode doesn't
;; yet pick up (eg. parent classes), Rails/Merb keywords, or non Ruby code related areas
;; (eg. dired, HTML, etc). Please feel free to customize further and send in any improvements,
;; patches most welcome.
;;
;; MIT License Copyright (c) 2008 Marcus Crafter <crafterm@redartisan.com>
;; Credits due to the excellent TextMate Twilight theme
;;

(defun color-theme-twilight ()
  "Color theme by Marcus Crafter, based off the TextMate Twilight theme, created 2008-04-18"
  (interactive)
  (color-theme-install
   '(color-theme-twilight
     ((background-color . "black")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "#A7A7A7")
      (foreground-color . "#F8F8F8")
      (mouse-color . "sienna1"))
     (default ((t (:background "black" :foreground "white"))))
     (blue ((t (:foreground "blue"))))
     (bold ((t (:bold t))))
     (bold-italic ((t (:bold t))))
     (border-glyph ((t (nil))))
     (buffers-tab ((t (:background "black" :foreground "white"))))

     (font-lock-builtin-face ((t (:foreground "white"))))
     (font-lock-comment-face ((t (:italic t :foreground "#5F5A60"))))
     (font-lock-constant-face ((t (:foreground "#CF6A4C"))))
     (font-lock-doc-string-face ((t (:foreground "DarkOrange"))))
     (font-lock-function-name-face ((t (:foreground "#9B703F"))))
     (font-lock-keyword-face ((t (:foreground "#CDA869"))))
     (font-lock-preprocessor-face ((t (:foreground "Aquamarine"))))
     (font-lock-reference-face ((t (:foreground "SlateBlue"))))

     (font-lock-regexp-grouping-backslash ((t (:foreground "#E9C062"))))
     (font-lock-regexp-grouping-construct ((t (:foreground "red"))))

     (font-lock-string-face ((t (:foreground "#8F9D6A"))))
     (font-lock-type-face ((t (:foreground "#9B703F"))))
     (font-lock-variable-name-face ((t (:foreground "#7587A6"))))
     (font-lock-warning-face ((t (:bold t :foreground "Pink"))))
     
     (diff-header ((t (:foreground "white" :background "#0E2231"))))
     (diff-added ((t (:foreground "white" :background "#253B22"))))
     (diff-removed ((t (:foreground "white" :background "#420E09"))))
     (diff-changed ((t (:foreground "white" :background "#4A410D"))))
     (diff-context ((t (:bold nil))))
     (diff-index ((t (:inherit font-lock-comment))))
     (diff-file-header ((t (:inherit font-lock-comment))))

     (ediff-current-diff-A ((((class color) (min-colors 16)) (:background "#01243C" :foreground "white"))))
     (ediff-current-diff-Ancestor ((((class color) (min-colors 16)) (:background "#4D0600" :foreground "white"))))
     (ediff-current-diff-B ((((class color) (min-colors 16)) (:background "#574A00" :foreground "white"))))
     (ediff-current-diff-C ((((class color) (min-colors 16)) (:background "#5C285C" :foreground "white"))))
     (ediff-even-diff-A ((((class color) (min-colors 16)) (:background "#222222"))))
(ediff-even-diff-Ancestor ((((class color) (min-colors 16)) (:background "#222222"))))
(ediff-even-diff-B ((((class color) (min-colors 16)) (:background "#222222"))))
(ediff-even-diff-C ((((class color) (min-colors 16)) (:background "#222222"))))
(ediff-fine-diff-A ((((class color) (min-colors 16)) (:background "#0B5C00" :foreground "white"))))
(ediff-fine-diff-Ancestor ((((class color) (min-colors 16)) (:background "#0B5C00" :foreground "white"))))
(ediff-fine-diff-B ((((class color) (min-colors 16)) (:background "#0B5C00" :foreground "white"))))
(ediff-fine-diff-C ((((class color) (min-colors 16)) (:background "#0B5C00" :foreground "white"))))
(ediff-odd-diff-A ((((class color) (min-colors 16)) (:background "#222222"))))
(ediff-odd-diff-Ancestor ((((class color) (min-colors 16)) (:background "#222222"))))
(ediff-odd-diff-B ((((class color) (min-colors 16)) (:background "#222222"))))
 
     

     (gui-element ((t (:background "#D4D0C8" :foreground "black"))))
     (region ((t (:background "#27292A"))))
     (minibuffer-prompt ((t (:foreground "cyan"))))
     (mode-line ((t (:background "grey75" :foreground "black"))))
     (highlight ((t (:background "#222222"))))
     (highline-face ((t (:background "SeaGreen"))))
     (italic ((t (nil))))
     (left-margin ((t (nil))))
     (text-cursor ((t (:background "yellow" :foreground "black"))))
     (toolbar ((t (nil))))
     (underline ((nil (:underline nil))))
     (zmacs-region ((t (:background "snow" :foreground "ble")))))))