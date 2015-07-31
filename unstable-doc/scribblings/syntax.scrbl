#lang scribble/manual
@(require scribble/struct scribble/decode scribble/eval "utils.rkt"
          (for-label racket/base racket/contract syntax/kerncase
                     racket/syntax unstable/syntax))

@(define the-eval (make-base-eval))
@(the-eval '(require unstable/syntax (for-syntax racket/base unstable/syntax)))

@title[#:tag "syntax"]{Syntax}
@unstable[@author+email["Ryan Culpepper" "ryanc@racket-lang.org"]]

@defmodule[unstable/syntax]

@defproc[(explode-module-path-index [mpi module-path-index?])
         (listof (or/c module-path? resolved-module-path? #f))]{

Unfolds @racket[mpi] using @racket[module-path-index-split], returning
a list of the relative module paths together with the terminal
resolved module path or @racket[#f] for the ``self'' module.

@examples[#:eval the-eval
(explode-module-path-index (car (identifier-binding #'lambda)))
(explode-module-path-index (caddr (identifier-binding #'lambda)))
(explode-module-path-index (car (identifier-binding #'define-values)))
]
}

@defform[(phase-of-enclosing-module)]{

Returns the phase level of the module in which the form occurs (and
for the instantiation of the module in which the form is
executed). For example, if a module is required directly by the
``main'' module (or the top level), its phase level is 0. If a module
is required for-syntax by the ``main'' module (or the top level), its
phase level is 1.

@examples[#:eval the-eval
(module helper racket
  (require unstable/syntax)
  (displayln (phase-of-enclosing-module)))
(require 'helper)
(require (for-meta 1 'helper))
]
}

@;{----}

@addition{@author+email["Vincent St-Amour" "stamourv@racket-lang.org"]}
@defproc[(format-unique-id [lctx (or/c syntax? #f)]
                           [fmt string?]
                           [v (or/c string? symbol? identifier? keyword? char? number?)] ...
                           [#:source src (or/c syntax? #f) #f]
                           [#:props props (or/c syntax? #f) #f]
                           [#:cert cert (or/c syntax? #f) #f])
         identifier?]{
Like @racket[format-id], but returned identifiers are guaranteed to be unique.
}
@defproc[(syntax-within? [a syntax?] [b syntax?])
         boolean?]{
Returns true is syntax @racket[a] is within syntax @racket[b] in the source.
Bounds are inclusive.
}

@;{----}

@addition{@author+email["Eric Dobson" "eric.n.dobson@gmail.com"]}

@defproc[(syntax-length [stx syntax?]) exact-nonnegative-integer?]{
Performs @racket[(length (syntax->list stx))].

@examples[#:eval the-eval
(syntax-length #'(d e f))]
}

@close-eval[the-eval]
