#lang scribble/manual
@(require "../utils.rkt"
          scribble/eval
          (for-label racket/base
                     racket/contract
                     racket/class
                     racket/draw
                     racket/future
                     pict
                     pict/color
                     pict/conditional
                     unstable/contract
                     unstable/gui/pict))

@(define the-eval (make-base-eval))
@(the-eval '(require racket/math pict unstable/gui/pict))

@title[#:tag "pict"]{Pict Utilities}
@deprecated[@racketmodname[pict]]{
The contents of this module, with the exceptions below, have been merged with
the @racketmodname[pict] collection, or its subcollections.
}

@defmodule[unstable/gui/pict]

The functions and macros exported by this module are also exported by
@racketmodname[unstable/gui/slideshow].

@;{----------------------------------------}

@section{Pict Colors}

@defproc[(color [c color/c] [p pict?]) pict?]{

Applies color @racket[c] to picture @racket[p].  Equivalent to @racket[(colorize
p c)].

@examples[#:eval the-eval
(color "red" (disk 20))
]
}

@;{----------------------------------------}

@section{Pict Manipulation}

@defproc[(fill [pict pict?] [width (or/c real? #f)] [height (or/c real? #f)])
         pict?]{

Extends @racket[pict]'s bounding box to a minimum @racket[width] and/or
@racket[height], placing the original picture in the middle of the space.

@examples[#:eval the-eval
(frame (fill (disk 20) 40 40))
]
}

@defproc[(scale-to [pict pict?]
                   [width real?]
                   [height real?]
                   [#:mode mode (or/c 'preserve 'inset 'distort) 'preserve])
         pict?]{

Scales @racket[pict] so that its width and height are at most
@racket[width] and @racket[height], respectively. If @racket[mode] is
@racket['preserve], the width and height are scaled by the same factor
so @racket[pict]'s aspect ratio is preserved; the result's bounding
box may be smaller than @racket[width] by @racket[height]. If
@racket[mode] is @racket['inset], the aspect ratio is preserved as
with @racket['preserve], but the resulting pict is centered in a
bounding box of exactly @racket[width] by @racket[height]. If
@racket[mode] is @racket['distort], the width and height are scaled
separately.

@examples[#:eval the-eval
(frame (scale-to (circle 100) 40 20))
(frame (scale-to (circle 100) 40 20 #:mode 'inset))
(frame (scale-to (circle 100) 40 20 #:mode 'distort))
]
}

@subsection{Conditional Manipulations}

These pict transformers all take boolean arguments that determine whether to
transform the pict or leave it unchanged.  These transformations can be useful
for staged slides, as the resulting pict always has the same size and shape, and
its contents always appear at the same position, but changing the boolean
argument between slides can control when the transformation occurs.

@defproc[(strike [pict pict?] [strike? truth/c #t]) pict?]{

Displays a strikethrough image by putting a line through the middle of
@racket[pict] if @racket[strike?] is true; produces @racket[pict] unchanged
otherwise.

@examples[#:eval the-eval
(strike (colorize (disk 20) "yellow"))
]
}

@defproc[(shade [pict pict?]
                [shade? truth/c #t]
                [#:ratio ratio (real-in 0 1) 1/2])
         pict?]{

Shades @racket[pict] to show with @racket[ratio] of its normal opacity; if
@racket[ratio] is @racket[1] or @racket[shade?] is @racket[#f], shows
@racket[pict] unchanged.

@examples[#:eval the-eval
(shade (colorize (disk 20) "red"))
]
}

@subsection{Conditional Combinations}

These bindings provide additional control over the combinations in
@racketmodname[pict/conditional].

@defform[#:id pict-combine pict-combine]{

This syntax parameter determines the default pict combining form used by the
combinaitons in @racketmodname[pict/conditional].
It defaults to @racket[lbl-superimpose].
}

@defform[(with-pict-combine combine-id body ...)]{

Sets @racket[pict-combine] to refer to @racket[combine-id] within each of the
@racket[body] terms, which are spliced into the containing context.

@examples[#:eval the-eval
(let ([f (lambda (x)
           (with-pict-combine cc-superimpose
             (pict-case x
               [(circle) (circle 20)]
               [(disk) (disk 40)]
               [(text) (text "ok" null 20)])))])
  (hc-append 10
             (frame (f 'circle))
             (frame (f 'disk))
             (frame (f 'text))))
]
}

@defform/subs[(pict-match test-expr maybe-combine [pattern pict-expr] ...)
              ([maybe-combine code:blank (code:line #:combine combine-expr)])]{

Chooses a @racket[pict-expr] based on @racket[test-expr] and each
@racket[pattern], similarly to @racket[match].  Combines the chosen, visible
image with the other, invisible images using @racket[combine-expr], defaulting
to @racket[lbl-superimpose].

}

@section{Shapes with Borders}

@addition{Vincent St-Amour}

@deftogether[(
@defproc[(ellipse/border [w real?] [h real?]
                         [#:color color color/c "white"]
                         [#:border-color border-color color/c "black"]
                         [#:border-width border-width real? 2])
         pict?]
@defproc[(circle/border [diameter real?]
                        [#:color color color/c "white"]
                        [#:border-color border-color color/c "black"]
                        [#:border-width border-width real? 2])
         pict?]
@defproc[(rectangle/border [w real?] [h real?]
                           [#:color color color/c "white"]
                           [#:border-color border-color color/c "black"]
                           [#:border-width border-width real? 2])
         pict?]
@defproc[(rounded-rectangle/border [w real?] [h real?]
                                   [#:color color color/c "white"]
                                   [#:border-color border-color color/c "black"]
                                   [#:border-width border-width real? 2]
                                   [#:corner-radius corner-radius real? -0.25]
                                   [#:angle angle real? 0])
         pict?]
)]{
These functions create shapes with border of the given color and width.

@examples[#:eval the-eval
(ellipse/border 80 40 #:border-color "blue")
(rounded-rectangle/border 60 60 #:color "red" #:angle 1 #:border-width 3)
(circle/border 40 #:color "green" #:border-color "purple")
(rectangle/border 200 20 #:border-width 5)
]
}

@section{Lines with Labels}

@addition{Scott Owens}

@deftogether[(
@defproc[(pin-label-line [label pict?] [pict pict?]
                         [src-pict pict-path?]
			 [src-coord-fn (-> pict-path? (values real? real?))]
                         [dest-pict pict-path?]
			 [dest-coord-fn (-> pict-path? (values real? real?))]
			 [#:start-angle start-angle (or/c real? #f) #f]
			 [#:end-angle end-angle (or/c real? #f) #f]
			 [#:start-pull start-pull real? 1/4]
			 [#:end-pull end-pull real? 1/4]
			 [#:line-width line-width (or/c real? #f) #f]
			 [#:color color (or/c #f string? (is-a?/c color%)) #f]
			 [#:alpha alpha (real-in 0 1) 1]
			 [#:style style pen-style/c 'solid]
			 [#:under? under? any/c #f]
			 [#:x-adjust x-adjust real? 0]
			 [#:y-adjust y-adjust real? 0])
	 pict?]
@defproc[(pin-arrow-label-line [label pict?] [arrow-size real?] [pict pict?]
                         [src-pict pict-path?]
			 [src-coord-fn (-> pict-path? (values real? real?))]
                         [dest-pict pict-path?]
			 [dest-coord-fn (-> pict-path? (values real? real?))]
			 [#:start-angle start-angle (or/c real? #f) #f]
			 [#:end-angle end-angle (or/c real? #f) #f]
			 [#:start-pull start-pull real? 1/4]
			 [#:end-pull end-pull real? 1/4]
			 [#:line-width line-width (or/c real? #f) #f]
			 [#:color color (or/c #f string? (is-a?/c color%)) #f]
			 [#:alpha alpha (real-in 0 1) 1]
			 [#:style style pen-style/c 'solid]
			 [#:solid? solid? boolean? #t]
			 [#:under? under? any/c #f]
			 [#:hide-arrowhead? hide-arrowhead? any/c #f]
			 [#:x-adjust x-adjust real? 0]
			 [#:y-adjust y-adjust real? 0])
	 pict?]
@defproc[(pin-arrows-label-line [label pict?] [arrow-size real?] [pict pict?]
                         [src-pict pict-path?]
			 [src-coord-fn (-> pict-path? (values real? real?))]
                         [dest-pict pict-path?]
			 [dest-coord-fn (-> pict-path? (values real? real?))]
			 [#:start-angle start-angle (or/c real? #f) #f]
			 [#:end-angle end-angle (or/c real? #f) #f]
			 [#:start-pull start-pull real? 1/4]
			 [#:end-pull end-pull real? 1/4]
			 [#:line-width line-width (or/c real? #f) #f]
			 [#:color color (or/c #f string? (is-a?/c color%)) #f]
			 [#:alpha alpha (real-in 0 1) 1]
			 [#:style style pen-style/c 'solid]
			 [#:solid? solid? boolean? #t]
			 [#:under? under? any/c #f]
			 [#:hide-arrowhead? hide-arrowhead? any/c #f]
			 [#:x-adjust x-adjust real? 0]
			 [#:y-adjust y-adjust real? 0])
	 pict?]
)]{
These functions behave like @racket[pin-line], @racket[pin-arrow-line]
and @racket[pin-arrows-line] with the addition of a label attached to
the line.

@examples[#:eval the-eval
(let* ([a (red (disk 20))]
       [b (blue (filled-rectangle 20 20))]
       [p (vl-append a (hb-append (blank 100) b))])
  (pin-arrow-label-line 
   (rotate (text "label" null 10) (/ pi -4))
   10 p
   a rb-find
   b lt-find))
]
}

@section{Blur}
@addition{Ryan Culpepper}

@defproc[(blur-bitmap! [bitmap (is-a?/c bitmap%)]
                       [h-radius (and/c real? (not/c negative?))]
                       [v-radius (and/c real? (not/c negative?)) h-radius])
         void?]{

Blurs @racket[bitmap] using blur radii @racket[h-radius] and
@racket[v-radius].
}


@section{Shadow Frames}

@defproc[(arch [outer-width real?]
               [inner-width real?]
               [solid-height real?]
               [leg-height real?])
         pict?]{

Creates an arch.

@examples[#:eval the-eval
(colorize (arch 100 80 20 20) "red")
]
}

@section{Drawing}
@addition{Jay McCarthy}

@defproc[(draw-pict-centered [p pict?] [dc (is-a?/c dc<%>)] [w real?] [h real?]) void?]{
 Draws the pict @racket[p] on @racket[dc] centered in a @racket[w]x@racket[h] rectangle.
}

@section{Additional combinators}

@addition{Asumu Takikawa}

@defproc[(backdrop [pict pict?] [#:color color color/c "white"]) pict?]{
Adds a background highlighted with @racket[color] to
@racket[pict].

@examples[#:eval the-eval
  (backdrop (circle 20) #:color "whitesmoke")
  (backdrop (text "broccoli rabé") #:color "PaleGreen")
]}

@defproc[(cross-out [pict pict?]
                    [#:width width real? 1]
                    [#:style style
                     (or/c 'transparent 'solid 'xor
                           'hilite 'dot 'long-dash 'short-dash
                           'dot-dash 'xor-dot 'xor-long-dash
                           'xor-short-dash 'xor-dot-dash)
                     'solid]
                    [#:color color color/c "black"])
                    pict?]{
  Crosses out @racket[pict] with two diagonal lines drawn with
  the given line @racket[width] and with the line @racket[style].
  The lines are colored with @racket[color].

@examples[#:eval the-eval
  (cross-out (circle 20))
  (cross-out (rectangle 30 20) #:width 2 #:style 'long-dash)
  (cross-out (text "rapini") #:width 3 #:color "red")
]}

@(close-eval the-eval)

@section{PLT Logos}

@(require (for-label unstable/gui/pict/plt-logo))
@defmodule[unstable/gui/pict/plt-logo]

@addition{Jay McCarthy}

@defproc[(make-plt-title-background [w real?] [h real?]) pict?]{Draws the PLT logo inside a @racket[w]x@racket[h] rectangle.}
