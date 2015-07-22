#lang scribble/manual
@(require scribble/eval "utils.rkt" (for-label racket unstable/logging))

@(define the-eval (make-base-eval))
@(the-eval '(require unstable/logging))

@title{Logging}

@deprecated[@racketmodname[racket/logging]]{
The contents of this module, with the exceptions below, have been merged with
@racketmodname[racket/logging].
}

@defmodule[unstable/logging]

@deftogether[[
  @defproc[(start-recording
            [log-spec (or/c 'fatal 'error 'warning 'info 'debug symbol? #f)] ...)
           listener?]
  @defproc[(stop-recording [listener listener?])
           (listof (vector/c (or/c 'fatal 'error 'warning 'info 'debug)
                             string?
                             any/c
                             (or/c symbol? #f)))]]]{

@racket[start-recording] starts recording log messages matching the given
@racket[log-spec] (see @racket[make-log-receiver] for how @racket[log-spec] is
interpreted). Messages will be recorded until stopped by passing the returned
listener object to @racket[stop-recording]. @racket[stop-recording] will then
return a list of the log messages that have been reported.

@defexamples[
#:eval the-eval
(define l (start-recording 'warning))
(log-warning "1")
(log-warning "2")
(stop-recording l)
]}


@close-eval[the-eval]
