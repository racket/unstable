#lang racket/base

;; Re-exports from `framework/preferences`, for backwards compatibility.
(require framework/preferences)
(provide (rename-out [preferences:get/set pref:get/set]))
