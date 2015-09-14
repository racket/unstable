#lang scribble/doc
@(require scribble/base
          scribble/manual
          "utils.rkt"
          (for-syntax racket/base racket/path)
          (for-label scribble/base))

@unstable-title[#:tag "unstable"]

This manual documents some of the libraries available in the
@racketidfont{unstable} collection. See also @other-doc['(lib
"unstable/scribblings/gui/unstable-gui.scrbl") #:indirect "unstable
GUI libraries"].

The name @racketidfont{unstable} is intended as a warning that the
@bold{interfaces} in particular are unstable. Developers of planet
packages and external projects should avoid using modules in the
unstable collection. Contracts may change, names may change or
disappear, even entire modules may move or disappear without warning
to the outside world.

@local-table-of-contents[#:style 'immediate-only]

@;{--------}

@;{
  Add new documentation links to the list immediately below.
}

@include-section["automata.scrbl"]
@include-section["bytes.scrbl"]
@include-section["contract.scrbl"]
@include-section["wrapc.scrbl"]
@include-section["debug.scrbl"]
@include-section["define.scrbl"]
@include-section["error.scrbl"]
@include-section["find.scrbl"]
@include-section["future.scrbl"]
@include-section["function.scrbl"]
@include-section["hash.scrbl"]
@include-section["class-iop.scrbl"] ;; Interface-oriented Programming
@include-section["lazy-require.scrbl"]
@include-section["list.scrbl"]
@include-section["logging.scrbl"]
@include-section["macro-testing.scrbl"]
@include-section["markparam.scrbl"]
@include-section["match.scrbl"]
@include-section["open-place.scrbl"]
@include-section["options.scrbl"]
@include-section["parameter-group.scrbl"]
@include-section["pretty.scrbl"]
@include-section["recontract.scrbl"]
@include-section["sandbox.scrbl"]
@include-section["sequence.scrbl"]
@include-section["string.scrbl"]
@include-section["struct.scrbl"]
@include-section["custom-write.scrbl"] ;; Struct Printing
@include-section["syntax.scrbl"]
@include-section["temp-c.scrbl"]
@include-section["socket.scrbl"] ;; Unix Domain Sockets
@include-section["2d.scrbl"]
