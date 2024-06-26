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
      (scroll-bar-mode -1))
  (menu-bar-mode -1))

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

(server-start)

(setenv "PATH" (concat (getenv "PATH") ":/opt/homebrew/bin"))
(setq exec-path (cons "/opt/homebrew/bin" exec-path))

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

(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (ido-mode 1))

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

(if (display-graphic-p)
    (progn
      (use-package twilight-bright-theme
        :ensure t
        :config (load-theme 'twilight-bright t)))
  (use-package gruvbox-theme
    :ensure t
    :config (load-theme 'ayu-dark t)))


(use-package helm
  :ensure t
  :bind (("M-a" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ("C-SPC" . helm-dabbrev)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-buffers-list)
	 ("M-[" . helm-resume)
	 ("M-]" . helm-refresh))
  :bind (:map helm-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-I" . helm-previous-page)
	      ("M-K" . helm-next-page)
	      ("M-h" . helm-beginning-of-buffer)
	      ("M-1" . helm-toggle-full-frame)
	      ("M-H" . helm-end-of-buffer))
  :config (progn
	    (setq helm-buffers-fuzzy-matching t)
            (helm-mode 1)))
(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds))
(use-package helm-files
  :bind (:map helm-find-files-map
	      ("M-i" . nil)
	      ("M-l" . nil)
	      ("M-L" . nil)
	      ("M-j" . nil)
	      ("M-J" . nil)
	      ("M-k" . nil)
	      ("M-I" . nil)
	      ("M-K" . nil)
	      ("M-h" . nil)
	      ("M-H" . nil)))
(use-package swiper
  :ensure t
  :bind (("M-C-f" . swiper-thing-at-point)
	 ("C-f" . swiper)
	 ("M-m" . swiper-thing-at-point))
  :config
  (bind-keys :map ivy-minibuffer-map
             ("M-i" . nil)
             ("M-k" . nil)))
;; (use-package helm-swoop
;;   :ensure t
;;   :bind (("C-f" . helm-swoop)
;; 	 ("M-m" . helm-swoop)
;; 	 ("M-M" . helm-multi-swoop))
;;   :init
;;   (bind-key "M-m" 'helm-swoop-from-isearch isearch-mode-map)
;;   :config
;;   (bind-keys :map helm-swoop-map
;;              ("M-i" . nil)
;;              ("M-o" . helm-multi-swoop-all-from-helm-swoop)))
(use-package helm-ag
  :ensure helm-ag
  :bind ("M-P" . helm-ag)
  :commands (helm-ag helm-projectile-ag)
  :init (setq helm-ag-insert-at-point 'symbol
	      helm-ag-command-option "--path-to-ignore ~/.agignore"))
(use-package helm-dash
  :ensure t)

(use-package projectile
  :ensure t
  :bind (("C-p s" . projectile-switch-open-project)
	 ("C-x p" . projectile-switch-project))
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package helm-projectile
  :ensure t
  :bind (("M-p" . helm-projectile-ag)
	 ("M-t" . helm-projectile-find-file)
	 :map helm-projectile-find-file-map
	 ("M-l" . nil))
  :config
  (helm-projectile-on))

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
		  enh-ruby-bounce-deep-indent t
		  enh-ruby-hanging-indent-level 2)
	    (setq enh-ruby-program "/Users/senny/.asdf/installs/ruby/3.3.1/bin/ruby")
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

(use-package rbenv
  :ensure t
  :defer t
  :init (setq rbenv-show-active-ruby-in-modeline nil)
  :config (progn
            (global-rbenv-mode)
            (add-hook 'enh-ruby-mode-hook 'rbenv-use-corresponding)))

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

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :branch "main"
                   :files ("dist" "*.el"))
  :bind (:map copilot-completion-map
	      ("<tab>" . copilot-accept-completion)
	      ("TAB" . copilot-accept-completion))
  :config

  (setq copilot-node-executable "/Users/senny/.asdf/installs/nodejs/16/bin/node")
  (add-to-list 'copilot-major-mode-alist '("enh-ruby" . "ruby")))
  ;; (add-hook 'js2-mode-hook #'js2-refactor-mode)))

(use-package asdf
  :quelpa (asdf-enable :fetcher github
                       :repo "tabfugnic/asdf.el"
                       :branch "main"
                       :files ("asdf.el"))
  :config
  (asdf-enable))

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
   '("bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" default))
 '(package-selected-packages
   '(ayu-theme gruvbox-theme lua-mode vertico helm-lsp lsp-mode asdf typescript-mode svelte-mode swiper-helm color-theme-sanityinc-tomorrow yaml-mode web-mode use-package twilight-bright-theme swift-mode slim-mode rubocop rspec-mode rbenv minitest markdown-mode magit helm-swoop helm-projectile helm-descbinds helm-ag go-mode flycheck enh-ruby-mode drag-stuff diminish ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
