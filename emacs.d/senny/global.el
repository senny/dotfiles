(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq cua-highlight-region-shift-only t)
(prefer-coding-system 'utf-8)
(setq vc-handled-backends nil)

(setq hippie-expand-try-function-list
      '(yas/hippie-try-expand try-expand-dabbrev
                              try-expand-dabbrev-all-buffers
                              try-expand-dabbrev-from-kill
                              try-expand-dabbrev-from-kill))

(global-set-key (kbd "TAB") 'hippie-expand)

(when (functionp 'tool-bar-mode)
  (tool-bar-mode nil))

;; highlight
(show-paren-mode t)

;; Use a vertical bar as cursor
(blink-cursor-mode t)
(setq-default cursor-type '(bar . 2))
