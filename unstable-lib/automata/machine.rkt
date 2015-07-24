#lang racket/base

;; Re-exports from `automata/machine`, for backwards compatibility.
(require automata/machine)
(provide machine?
         machine-accepting?
         machine
         machine-accepting
         machine-explain
         machine-accepts?
         machine-accepts?/prefix-closed
         machine-null
         machine-epsilon
         machine-sigma*
         machine-complement
         machine-union
         machine-intersect
         machine-delay
         machine-seq*
         machine-seq
         machine-star)
