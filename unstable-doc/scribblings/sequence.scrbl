#lang scribble/manual
@(require scribble/eval "utils.rkt"
          (for-label racket/base unstable/sequence racket/contract))

@(define the-eval (make-base-eval))
@(the-eval '(require unstable/sequence))

@title[#:tag "sequence"]{Sequences}
@deprecated[@racketmodname[racket/sequence]]{
The contents of this module, with the exceptions below, have been merged with
@racketmodname[racket/sequence].
}

@defmodule[unstable/sequence]

@defproc[(in-pairs [seq sequence?]) sequence?]{
Produces a sequence equivalent to
 @racket[(in-parallel (sequence-lift car seq) (sequence-lift cdr seq))].
}

@defproc[(in-sequence-forever [seq sequence?] [val any/c]) sequence?]{
Produces a sequence whose values are the elements of @racket[seq], followed by @racket[val] repeated.
}

@defproc[(sequence-lift [f procedure?] [seq sequence?]) sequence?]{
Produces the sequence of @racket[f] applied to each element of @racket[seq].
@examples[#:eval the-eval
(for/list ([x (sequence-lift add1 (in-range 10))])
  x)]
}

@close-eval[the-eval]
