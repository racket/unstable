#lang scribble/manual
@(require scribble/eval "utils.rkt" (for-label racket unstable/function))

@(define the-eval (make-base-eval))
@(the-eval '(require unstable/function))

@title{Functions}
@unstable[@author+email["Carl Eastlund" "cce@racket-lang.org"]]

@defmodule[unstable/function]

@deprecated[@racketmodname[racket/function]]{
The contents of this module have been merged with
@racketmodname[racket/function].
}
