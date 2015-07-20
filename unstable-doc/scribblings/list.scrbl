#lang scribble/doc
@(require scribble/base scribble/manual scribble/eval "utils.rkt"
          (for-label racket/base racket/dict syntax/id-table racket/contract
                     unstable/list))

@(define the-eval (make-base-eval))
@(the-eval '(require unstable/list))

@title[#:tag "list"]{Lists}

@deprecated[@racketmodname[racket/list]]{
The contents of this module, with the exceptions below, have been merged with
@racketmodname[racket/list].
}

@defmodule[unstable/list]

@addition{Sam Tobin-Hochstadt}

@defproc[(filter-multiple [l list?] [f procedure?] ...) (values list? ...)]{
Produces @racket[(values (filter f l) ...)].

@examples[#:eval the-eval
(filter-multiple (list 1 2 3 4 5) even? odd?)
]
}

@defproc[(extend [l1 list?] [l2 list?] [v any/c]) list?]{
Extends @racket[l2] to be as long as @racket[l1] by adding @racket[(-
(length l1) (length l2))] copies of @racket[v] to the end of
@racket[l2].

@examples[#:eval the-eval
(extend '(1 2 3) '(a) 'b)
]}


@addition{Carl Eastlund}

@defproc[(map/values [n natural-number/c]
                     [f (-> A ... (values B_1 ... B_n))]
                     [lst (listof A)]
                     ...)
         (values (listof B_1) ... (listof B_n))]{

@deprecated[@racket[for/lists]]{}

Produces lists of the respective values of @racket[f] applied to the elements in
@racket[lst ...] sequentially.

@defexamples[
#:eval the-eval
(map/values
 3
 (lambda (x)
   (values (+ x 1) x (- x 1)))
 (list 1 2 3))
]

}

@defproc[(map2 [f (-> A ... (values B C))] [lst (listof A)] ...)
         (values (listof B) (listof C))]{

@deprecated[@racket[for/lists]]{}

Produces a pair of lists of the respective values of @racket[f] applied to the
elements in @racket[lst ...] sequentially.

@defexamples[
#:eval the-eval
(map2 (lambda (x) (values (+ x 1) (- x 1))) (list 1 2 3))
]

}

@close-eval[the-eval]
