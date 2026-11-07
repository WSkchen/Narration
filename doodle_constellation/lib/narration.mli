(** Narration layer: short invented myth generator.

    Produces a brief fictional story from the shape name and the matched
    star names.  The story is explicitly labelled as fiction; no
    astronomical measurements are included.

    This module uses only the information passed to it; it makes no
    external calls and has no side effects. *)

(** [generate ~shape_name ~stars ~constellation] returns a short
    paragraph (≤ 120 words) of invented mythology for a shape named
    [shape_name], anchored on [stars], near the official constellation
    [constellation].

    The returned string is plain text suitable for printing directly. *)
val generate
  :  shape_name   : string
  -> stars        : Star.t array
  -> constellation: string
  -> string
