(** ASCII sky renderer.

    Draws a rectangular star chart in the terminal using Unicode/ASCII
    block characters and ANSI 256-colour codes.  Brighter stars use
    heavier glyphs; matched stars are highlighted in yellow.

    The chart is a stereographic-like projection centred on [center_ra],
    [center_dec].  For charts smaller than ~30° across the gnomonic and
    stereographic projections are indistinguishable. *)

(** [render_sky ~width ~height ~stars ~matched_names ~center_ra
    ~center_dec ~radius_deg] prints a star chart to stdout.

    - [width] × [height] is the character grid size.
    - [stars] is the full catalogue array.
    - [matched_names] is a list of star names to highlight (yellow ★).
    - [radius_deg] is the angular radius of the chart in degrees. *)
val render_sky
  :  width         : int
  -> height        : int
  -> stars         : Star.t array
  -> matched_names : string list
  -> center_ra     : float
  -> center_dec    : float
  -> radius_deg    : float
  -> unit

(** [print_match_summary result visibility] pretty-prints the full match
    summary including star names, RMSD, score, and viewing time. *)
val print_match_summary
  :  result     : Fitter.match_result
  -> visibility : Visibility.viewing_info
  -> unit
