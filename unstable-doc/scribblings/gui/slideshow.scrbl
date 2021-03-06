#lang scribble/manual
@(require "../utils.rkt"
          (for-label slideshow
                     unstable/contract
                     unstable/gui/slideshow))

@title{Slideshow Presentations}

@deprecated[@racketmodname[slideshow]]{
The contents of this module, with the exceptions below, have been merged with
the @racketmodname[slideshow] collection, or its subcollections.
They are either available from the @tt{slideshow-lib} package or the
@tt{staged-slide} package.
}

@defmodule[unstable/gui/slideshow]

This module also exports everything provided by
@racketmodname[unstable/gui/pict].

@section{Tables}

@defproc[(tabular [row (listof (or/c string? pict?))] ...
                  [#:gap gap natural-number/c gap-size]
                  [#:hgap hgap natural-number/c gap]
                  [#:vgap vgap natural-number/c gap]
                  [#:align align (->* [] [] #:rest (listof pict?) pict?) lbl-superimpose]
                  [#:halign halign (->* [] [] #:rest (listof pict?) pict?) align]
                  [#:valign valign (->* [] [] #:rest (listof pict?) pict?) align])
         pict?]{

Constructs a table containing the given @racket[row]s, all of which must be of
the same length.  Applies @racket[t] to each string in a @racket[row] to
construct a pict.  The @racket[hgap], @racket[vgap], @racket[halign], and
@racket[valign] are used to determine the horizontal and vertical gaps and
alignments as in @racket[table] (except that every row and column is uniform).

}

@section{Multiple Columns}

@defform[(two-columns one two)]{

Constructs a two-column pict using @racket[one] and @racket[two] as the two
columns.  Sets @racket[current-para-width] appropriately in each column.

}

@defproc[(mini-slide [pict pict?] ...) pict?]{

Appends each @racket[pict] vertically with space between them, similarly to the
@racket[slide] function.

}

@defproc[(columns [pict pict?] ...) pict?]{

Combines each @racket[pict] horizontally, aligned at the top, with space in
between.

}

@defform[(column width body ...)]{

Sets @racket[current-para-width] to @racket[width] during execution of the
@racket[body] expressions.

}

@defproc[(column-size [n exact-positive-integer?]
                      [r real? (/ n )])
         real?]{

Computes the width of one column out of @racket[n] that takes up a ratio of
@racket[r] of the available space (according to @racket[current-para-width]).

}

@section{Revealing Slides}

@addition{Jon Rafkind}

@defform[(reveal number expr ...)]{

Expands to either @racket[(show expr ...)] or @racket[(hide expr ...)] if
@racket[number] is greater than or equal to the current revealed slide within a
@racket[revealing-slide].

}

@defform[(revealing-slide expr ...)]{

Creates N slides where N is the maximum number given to a @racket[reveal]
expression as the first argument. Each slide has the current reveal number
incremented by one so progressive slides can reveal picts in that appear in
arbitrary places.

@racketblock[
(revealing-slide
  (hc-append (reveal 0 @t{I show up first})
             (reveal 1 @t{I show up second}))
  (reveal 1 @t{I also show up second}))
]

}

@defform[(items-slide (name ...) expr ...)]{

Creates N slides where N is the maximum number given to a @racket[reveal]
similar to @racket[revealing-slide]. Each slide will show the names on the left
hand side using right justification and only one reveal will be displayed on the
right. The order of the names will be matched with the current reveal number so
the first item will be displayed while the first reveal is displayed. Reveals
that are not active will have their corresponding items displayed but in a light
font so as to indicate inactivity.

@racketblock[
(items-slide ("item1" "item2" "item3")
  (reveal 0
    @t{I will show up for item1})
  (reveal 1
    @t{I will show up for item2})
  (reveal 2
    @t{I will show up for item3}))
]

}
