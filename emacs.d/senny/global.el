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