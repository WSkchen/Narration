(** Similarity fitter and scorer.

    For each candidate hypothesis the fitter:
    {ol
      {- Projects every drawing corner into the sky tangent plane using
         the hypothesis transform.}
      {- Greedily assigns each projected corner to the nearest unused
         catalogue star (within [max_assign_deg] degrees of angular
         separation).}
      {- Refines the transform using 2-D Procrustes on all assigned
         correspondences.}
      {- Scores the result by RMSD plus a penalty for unused bright
         stars that fall inside the bounding box of the shape.}
    }

    The best hypothesis is the one with the lowest score.

    This follows the RANSAC-inspired "generate-and-verify" logic
    described by Astrometry.net (Lang et al., 2010). *)

(** The result of a successful match. *)
type match_result = {
  stars      : Star.t array;
  (** Matched stars in drawing-corner order.  Array length equals the
      number of corners that were successfully assigned. *)
  transform  : Geometry.transform;
  (** Refined similarity transform from drawing space to tangent plane. *)
  rmsd_deg   : float;
  (** Root-mean-square angular deviation between corners and matched
      stars, in degrees.  Lower is a tighter fit. *)
  score      : float;
  (** Combined score (lower = better): rmsd_deg plus brightness penalty. *)
  center_ra  : float;
  (** RA of the tangent-plane centre, degrees. *)
  center_dec : float;
  (** Dec of the tangent-plane centre, degrees. *)
}

(** [fit ~catalogue ~corners ~max_assign_deg hyp]
    tests hypothesis [hyp] against [catalogue] and returns a
    [match_result] if at least 3 corners could be assigned.

    The projection centre is taken from [hyp.center_ra] / [hyp.center_dec].

    [max_assign_deg] is the maximum angular separation (degrees) allowed
    when greedily assigning a projected corner to its nearest star.
    Typical value: 8.0. *)
val fit
  :  catalogue      : Catalogue.t
  -> corners        : Geometry.point list
  -> max_assign_deg : float
  -> Candidate.hypothesis
  -> match_result option

(** [best_match ~catalogue ~corners ~max_assign_deg hyps] runs [fit] on
    every hypothesis in [hyps] and returns the result with the lowest
    score, or [None] if no hypothesis produced a valid fit. *)
val best_match
  :  catalogue      : Catalogue.t
  -> corners        : Geometry.point list
  -> max_assign_deg : float
  -> Candidate.hypothesis list
  -> match_result option
