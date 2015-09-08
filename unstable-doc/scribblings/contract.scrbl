#lang scribble/manual
@(require scribble/eval "utils.rkt" (for-label racket unstable/contract))

@(define the-eval (make-base-eval))
@(the-eval '(require racket/contract racket/dict unstable/contract))

@title[#:tag "contract"]{Contracts}
@deprecated[@racketmodname[racket/contract]]{
The contents of this module, with the exceptions below, have been merged with
@racketmodname[racket/contract].
}

@defmodule[unstable/contract]

@defthing[path-piece? contract?]{
Equivalent to @racket[(or/c path-string? (symbols 'up 'same))].
}

@addition{Asumu Takikawa}

@defproc[(maybe/c [contract contract?]) contract?]{

Creates a contract that acts like @racket[contract] but will also
accept @racket[#f]. Intended to describe situations where a failure
or default value may be used.
}

@addition[@author+email["Carl Eastlund" "cce@racket-lang.org"]]

@defthing[truth/c flat-contract?]{

This contract recognizes Racket truth values, i.e., any value, but with a more
informative name and description.  Use it in negative positions for arguments
that accept arbitrary truth values that may not be booleans.

}

@addition{@author+email["Neil Toronto" "neil.toronto@gmail.com"]}

@defproc[(treeof [elem-contract contract?]) contract?]{
Identifies values that meet the contract @racket[elem-contract], lists of such values, lists of lists, and so on.
@examples[#:eval the-eval
                 (define number-tree/c (treeof number?))
                 (flat-contract? number-tree/c)
                 (define number-tree? (flat-contract-predicate number-tree/c))
                 (number-tree? 4)
                 (number-tree? '(4 5))
                 (number-tree? '((4 5) 6))
                 (number-tree? '(4 . 5))]
}

@(close-eval the-eval)
