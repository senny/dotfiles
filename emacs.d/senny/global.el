(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq cua-highlight-region-shift-only t)
(prefer-coding-system 'utf-8)
(setq vc-handled-backends nil)

;; works in both aquamacs and carbon
(when (functionp 'tool-bar-mode)
  (tool-bar-mode))
