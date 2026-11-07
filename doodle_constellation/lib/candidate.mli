(** Candidate generator: turns simplified drawing corners into a list of
    match hypotheses via the geometric hash.

    For each triangle that can be formed from the drawing corners the
    module looks up matching star triples in the index, then derives the
    similarity transform (scale, rotation, translation) implied by the
    triangle correspondence.  Each (transform, star-triple) pair is a
    hypothesis passed to the fitter. *)

(** A single match hypothesis: a similarity transform mapping drawing
    space to the sky tangent plane, anchored on three specific stars. *)
type hypothesis = {
  transform    : Geometry.transform;
  anchor_stars : Star.t * Star.t * Star.t;  (** the three anchoring stars *)
  drawn_idx    : int * int * int;            (** indices into the corner list *)
  center_ra    : float;   (** RA of the local tangent-plane centre, degrees *)
  center_dec   : float;   (** Dec of the local tangent-plane centre, degrees *)
}

(** [generate ~index ~corners] returns all hypotheses produced by looking
    up each drawn triangle in [index].

    Each hypothesis carries the local projection centre (RA/Dec) used
    when that star triple was indexed so the fitter can project catalogue
    stars consistently.

    The list is not sorted; the fitter scores and ranks them. *)
val generate
  :  index       : Index.t
  -> corners     : Geometry.point list
  -> hypothesis list
