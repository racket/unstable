#lang scribble/manual
@(require scribble/eval "utils.rkt"
          (for-label racket/base unstable/struct racket/contract))

@(define the-eval (make-base-eval))
@(the-eval '(require unstable/struct))

@title[#:tag "struct"]{Structs}

@deprecated[@racketmodname[racket/struct]]{
The contents of this module, with the exceptions below, have been merged with
@racketmodname[racket/struct].
}

@defmodule[unstable/struct]

@defform[(make struct-id expr ...)]{

Creates an instance of @racket[struct-id], which must be bound as a
struct name. The number of @racket[expr]s is statically checked
against the number of fields associated with @racket[struct-id]. If
they are different, or if the number of fields is not known, an error
is raised at compile time.

@examples[#:eval the-eval
  (define-struct triple (a b c))
  (make triple 3 4 5)
  (make triple 2 4)
]
}

@close-eval[the-eval]
