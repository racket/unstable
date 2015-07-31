#lang racket/base
(require rackunit/docs-complete)
(check-docs (quote unstable/syntax))
(check-docs (quote unstable/struct))
(check-docs (quote unstable/string))
(check-docs (quote unstable/sequence))
(check-docs (quote unstable/pretty))
(check-docs (quote unstable/match))
; (check-docs (quote unstable/list)) re-exports stuff
(check-docs (quote unstable/find))
(check-docs (quote unstable/debug))
(check-docs (quote unstable/contract))
(check-docs (quote unstable/bytes))
