(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq cua-highlight-region-shift-only t)

(setq minibuffer-complete-cycle t)
(prefer-coding-system 'utf-8)

(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand 
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-dabbrev-from-kill))