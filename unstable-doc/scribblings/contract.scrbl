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

@defthing[port-number? contract?]{
Equivalent to @racket[(between/c 1 65535)].
}

@defthing[tcp-listen-port? contract?]{
Equivalent to @racket[(between/c 0 65535)].
}

@defthing[path-piece? contract?]{
Equivalent to @racket[(or/c path-string? (symbols 'up 'same))].
}

@addition{Ryan Culpepper}

@defproc[(if/c [predicate (-> any/c any/c)]
               [then-contract contract?]
               [else-contract contract?])
         contract?]{

Produces a contract that, when applied to a value, first tests the
value with @racket[predicate]; if @racket[predicate] returns true, the
@racket[then-contract] is applied; otherwise, the
@racket[else-contract] is applied. The resulting contract is a flat
contract if both @racket[then-contract] and @racket[else-contract] are
flat contracts.

For example, the following contract enforces that if a value is a
procedure, it is a thunk; otherwise it can be any (non-procedure)
value:
  @racketblock[(if/c procedure? (-> any) any/c)]
Note that the following contract is @bold{not} equivalent:
  @racketblock[(or/c (-> any) any/c) (code:comment "wrong!")]
The last contract is the same as @racket[any/c] because
@racket[or/c] tries flat contracts before higher-order contracts.
}

@defthing[failure-result/c contract?]{

A contract that describes the failure result arguments of procedures
such as @racket[hash-ref].

Equivalent to @racket[(if/c procedure? (-> any) any/c)].
}

@defproc[(rename-contract [contract contract?]
                          [name any/c])
         contract?]{

Produces a contract that acts like @racket[contract] but with the name
@racket[name].

The resulting contract is a flat contract if @racket[contract] is a
flat contract.
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
