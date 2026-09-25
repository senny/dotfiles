;;; init.el --- User Emacs configuration -*- lexical-binding: t -*-

;; Load Omarchy integration (theme syncing, font syncing, file watchers).
;; Remove this line to opt out of Omarchy Emacs integration.
(load (expand-file-name "omarchy" user-emacs-directory) 'noerror)

;; Your customizations below

(defvar senny-temporary-file-directory (expand-file-name "~/.emacs.d/tmp"))
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(require 'defuns-cfg)
(require 'keybindings-cfg)

(let ((font "DejaVuSansM Nerd Font"))
  (if (member font (font-family-list))
      (set-face-attribute 'default nil :font (concat font " 16"))))

(if window-system
    (progn
      (setq frame-title-format '(buffer-file-name "%f" ("%b")))
      (tooltip-mode -1)
      (mouse-wheel-mode t)
      (scroll-bar-mode -1)
      (menu-bar-mode -1)))

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(blink-cursor-mode -1)
(setq-default cursor-type '(bar . 2))
(global-hl-line-mode t)
(delete-selection-mode 1)
(transient-mark-mode 1)
(show-paren-mode 1)
(column-number-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-screen t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(electric-pair-mode 1)
(remove-trailing-whitespace-mode)
(setq-default require-final-newline 'visit-save)

(require 'server)
(unless (server-running-p)
  (server-start))

(setenv "PATH" (concat (getenv "PATH") ":/opt/homebrew/bin:/Users/senny/.local/bin"))
(setq exec-path (cons "/Users/senny/.local/bin" (cons "/opt/homebrew/bin" exec-path)))

;; Bootstrap `use-package'
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
	     '("gnu-devel" . "https://elpa.gnu.org/devel/"))
(package-initialize)

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade))
  (quelpa
   '(quelpa-use-package
     :fetcher github
     :repo "quelpa/quelpa-use-package")))
(require 'quelpa-use-package)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (add-to-list 'load-path (expand-file-name "vendor" user-emacs-directory)))

(use-package diff-mode
  :ensure t
  :bind (:map diff-mode-map
	      ("M-i" . nil)
	      ("M-j" . nil)
	      ("M-l" . nil)
	      ("M-k" . nil)
	      ("M-o" . nil)
	      ("M-u" . nil)
	      ("M-SPC" . nil)
	      ("M-I" . nil)
	      ("M-K" . nil)
	      ("M-h" . nil)
	      ("M-H" . nil)))

(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

(when (eq system-type 'darwin)
  (if (display-graphic-p)
      (progn
        (use-package twilight-bright-theme
          :ensure t
          :config (load-theme 'twilight-bright t)))
    (use-package gruvbox-theme
      :ensure t
      :config (load-theme 'ayu-dark t))))

;;; Minibuffer completion (Vertico stack)
;;
;; Vertico remaps `next-line', `previous-line', `beginning-of-buffer',
;; `end-of-buffer', `scroll-up-command', `scroll-down-command' and the
;; paragraph motions, so the custom M-i/M-k/M-h/M-H/M-I/M-K/M-U/M-O
;; navigation keys keep working in the minibuffer unchanged.

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode 1)
  :bind (("M-[" . vertico-repeat)         ; was helm-resume
         ("M-]" . vertico-repeat-select)) ; was helm-refresh
  :config
  (require 'vertico-repeat)
  (add-hook 'minibuffer-setup-hook #'vertico-repeat-save))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind (:map vertico-map
              ("C-l" . vertico-directory-up))) ; was helm-find-files-up-one-level

(use-package savehist
  :ensure nil
  :init
  (savehist-mode 1)
  :custom
  (savehist-additional-variables '(vertico-repeat-history)))

(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1)
  :custom
  (recentf-max-saved-items 200))

(use-package marginalia
  :ensure t
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :ensure t
  :bind (("C-x C-f" . find-file)                        ; was helm-find-files
         ("C-x f" . consult-recent-file)                ; was helm-recentf
         ("C-SPC" . hippie-expand)                      ; was helm-dabbrev
         ("M-y" . consult-yank-pop)                     ; was helm-show-kill-ring
         ("C-f" . consult-line)                         ; was swiper
         ("M-m" . senny-consult-line-thing-at-point)    ; was swiper-thing-at-point
         ("M-C-f" . senny-consult-line-thing-at-point)) ; was swiper-thing-at-point
  :config
  (setq consult-project-function #'senny-consult-project-root))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h b" . embark-bindings))                   ; was helm-descbinds
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :ensure t
  :after (embark consult))
(use-package projectile
  :ensure t
  :bind (("C-p s" . projectile-switch-open-project)
	 ("C-x p" . projectile-switch-project)
	 ("M-p" . consult-ripgrep)              ; was helm-projectile-rg
	 ("M-P" . senny-consult-ripgrep-thing-at-point) ; grep word at point
         ("M-n" . consult-imenu)
	 ("M-t" . projectile-find-file))        ; was helm-projectile-find-file
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/Work/"))
  (setq projectile-enable-caching t))

(use-package enh-ruby-mode
  :ensure t
  :defer t
  :mode (("\\.rb\\'"       . enh-ruby-mode)
         ("\\.ru\\'"       . enh-ruby-mode)
	 ("\\.jbuilder\\'" . enh-ruby-mode)
         ("\\.gemspec\\'"  . enh-ruby-mode)
         ("\\.rake\\'"     . enh-ruby-mode)
         ("Rakefile\\'"    . enh-ruby-mode)
         ("Gemfile\\'"     . enh-ruby-mode)
         ("Guardfile\\'"   . enh-ruby-mode)
         ("Capfile\\'"     . enh-ruby-mode)
         ("Vagrantfile\\'" . enh-ruby-mode))
  :config (progn
	    (setq enh-ruby-indent-level 2
		  enh-ruby-add-encoding-comment-on-save nil
		  enh-ruby-deep-indent-paren nil
		  enh-ruby-bounce-deep-indent nil
		  enh-ruby-hanging-indent-level 2)
	    (setq ruby-insert-encoding-magic-comment nil))
  :bind (:map enh-ruby-mode-map
	      ("C-M-f" . nil)))

(use-package rubocop
  :ensure t
  :defer t
  :init (add-hook 'ruby-mode-hook 'rubocop-mode))

(use-package minitest
  :ensure t
  :defer t)

(use-package rspec-mode
  :ensure t
  :defer t)

(use-package mise
  :ensure t
  :defer t
  :hook
  (after-init . global-mise-mode))

(use-package flycheck
  :ensure t
  :defer 5
  :config
  (global-flycheck-mode 1))

(use-package drag-stuff
  :ensure t
  :bind (("M-<up>" . drag-stuff-up)
	 ("M-<down>" . drag-stuff-down)
	 ("M-<left>" . indent-rigidly-left)
	 ("M-<right>" . indent-rigidly-right)))

(use-package magit
  :ensure t
  :defer 2
  :bind (("C-x g" . magit-status)))

(use-package slim-mode
  :ensure t
  :mode ("\\.slim\\'" . slim-mode))

(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :bind (:map markdown-mode-map
	      ("M-p" . nil)))

(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)
	 ("\\.mjml?\\'" . web-mode)
         ("\\.php\\'" . web-mode))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (indent-tabs-mode nil))

(use-package js2-mode
  :ensure t
  :defer t
  :mode "\\.js$"
  :config

  (electric-indent-mode -1)
  (setq js2-basic-offset 2)
  (setq js2-bounce-indent-p t)
  (setq js2-consistent-level-indent-inner-bracket-p t)
  (setq js2-pretty-multiline-decl-indentation-p t)
  (setq js2-strict-missing-semi-warning nil)
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

(use-package go-mode
  :defer t
  :ensure t
  :mode ("\\.go$" . go-mode))

(use-package svelte-mode
  :defer t
  :ensure t
  :mode ("\\.svelte$" . svelte-mode)
  :bind (:map html-mode-map
	      ("M-o" . nil)))

(use-package typescript-mode
  :defer t
  :ensure t
  :mode ("\\.ts$" . typescript-mode)
  :config (progn
            (setq typescript-indent-level 2)))

(use-package swift-mode
  :ensure t
  :bind (:map swift-mode-map
	      ("M-i" . nil)
	      ("M-j" . nil)
	      ("M-l" . nil)
	      ("M-k" . nil)
	      ("M-I" . nil)
	      ("M-K" . nil)
	      ("M-h" . nil)
	      ("M-H" . nil)))

;; (use-package eglot
;;   :ensure t
;;   ;; :hook ((( enh-ruby-mode)
;;   ;;         . eglot-ensure))
;;   :config
;;   (with-eval-after-load 'eglot
;;     (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode enh-ruby-mode) "ruby-lsp"))))

;; (use-package lsp-mode
;;   :ensure t
;;   :config
;;   (setq gc-cons-threshold 100000000)
;;   (setq read-process-output-max (* 1024 1024))
;;   (add-hook 'enh-ruby-mode-hook #'lsp)
;;   (with-eval-after-load "lsp-mode"
;;     (add-to-list 'lsp-disabled-clients 'rubocop-ls)))

;; (use-package helm-lsp
;;   :ensure t
;;   :commands helm-lsp-workspace-symbol
;;   :bind (:map lsp-mode-map
;; 	      ("M-n" . helm-lsp-workspace-symbol)
;; 	      ("M-p" . helm-lsp-workspace-symbol)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
