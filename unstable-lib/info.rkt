#lang info

(define collection "unstable")

(define deps '("automata-lib"
               ("base" #:version "6.2.900.6")
               ("draw-lib" #:version "1.7")
               "gui-lib"
               "markparam-lib"
               "pict-lib"
               "ppict"
               "scribble-lib"
               "slideshow-lib"
               "temp-c-lib"
               "unstable-macro-testing-lib"
               "unix-socket-lib"))
(define implies '("unstable-macro-testing-lib"))
(define build-deps '("rackunit-lib"))

(define pkg-desc "implementation (no documentation) part of \"unstable\"")

(define pkg-authors '(jay samth cce ryanc))
