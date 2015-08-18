#lang racket/base

;; Re-exports from `framework/notify`, for backwards compatibility.
(require framework/notify)
(provide (rename-out [notify:notify-box% notify-box%]
                     [notify:notify-box/pref notify-box/pref]
                     [notify:define-notify define-notify]
                     [notify:menu-option/notify-box menu-option/notify-box]
                     [notify:check-box/notify-box check-box/notify-box]
                     [notify:choice/notify-box choice/notify-box]
                     [notify:menu-group/notify-box menu-group/notify-box]))
