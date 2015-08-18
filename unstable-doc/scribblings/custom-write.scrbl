#lang scribble/doc
@(require scribble/base
          scribble/manual
          scribble/eval
          "utils.rkt"
          (for-label unstable/custom-write
                     racket/base
                     racket/contract
                     racket/pretty))

@title[#:tag "custom-write"]{Struct Printing}

@deprecated[@racketmodname[racket/struct]]{
The contents of this module, with the exceptions below, have been merged with
@racketmodname[racket/struct].
}

@defmodule[unstable/custom-write]

@(define the-eval (make-base-eval))
@(the-eval '(require unstable/custom-write racket/pretty))

@defthing[prop:auto-custom-write
          (struct-type-property/c 'constructor)]{

When attached to a struct type, automatically generates a printer using
@racket[make-constructor-style-printer] and attaches it to the struct type's
@racket[prop:custom-write] property. It also sets the
@racket[prop:custom-print-quotable] property to @racket['never].

@examples[#:eval the-eval
(struct point3 (x y z)
  #:property prop:auto-custom-write 'constructor)
(print (point3 3 4 5))
(write (point3 3 4 5))
]
}


@close-eval[the-eval]
