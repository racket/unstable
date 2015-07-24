#lang info

(define collection "unstable")

(define deps '("automata-lib"
               "base"
               "draw-lib"
               "gui-lib"
               "markparam-lib"
               "pict-lib"
               "ppict"
               "scribble-lib"
               "slideshow-lib"
               "temp-c-lib"
               "unstable-macro-testing-lib"))
(define implies '("unstable-macro-testing-lib"))
(define build-deps '("rackunit-lib"))

(define pkg-desc "implementation (no documentation) part of \"unstable\"")

(define pkg-authors '(jay samth cce ryanc))
