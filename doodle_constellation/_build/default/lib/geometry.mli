(** Two-dimensional geometry used throughout the matching pipeline.

    All angular quantities passed to projection functions are in degrees
    unless stated otherwise.  Internally the module works in radians. *)

(** A 2-D point in the tangent plane or in drawing space. *)
type point = { x : float; y : float }

(** A 2-D similarity transform T where T(p) = scale·R(angle)·p + (tx,ty).
    [angle] is a counter-clockwise rotation in radians. *)
type transform = {
  scale : float;
  angle : float;
  tx    : float;
  ty    : float;
}

(** The identity transform. *)
val identity : transform

(** [apply t p] returns T([p]) under transform [t]. *)
val apply : transform -> point -> point

(** [invert t] returns the unique inverse of [t].
    Requires [t.scale > 0]. *)
val invert : transform -> transform

(** [distance a b] is the Euclidean distance ||a - b||. *)
val distance : point -> point -> float

(** [gnomonic_project ~center_ra ~center_dec ~ra ~dec] projects the sky
    point ([ra],[dec]) onto the tangent plane whose pole is
    ([center_ra],[center_dec]).  Coordinates are in degrees; the return
    value is in radians (the natural unit of the tangent plane).

    The projection is undefined at angular distances ≥ 90° from the
    centre; the caller is responsible for filtering those cases. *)
val gnomonic_project
  :  center_ra:float -> center_dec:float
  -> ra:float -> dec:float
  -> point

(** [gnomonic_unproject ~center_ra ~center_dec p] is the inverse of
    [gnomonic_project]: given a tangent-plane point [p] in radians,
    returns [(ra, dec)] in degrees. *)
val gnomonic_unproject
  :  center_ra:float -> center_dec:float
  -> point
  -> float * float

(** [triangle_shape_key a b c] returns a rotation-, scale-, and
    translation-invariant integer triple describing the triangle (a,b,c).

    The key is (r1, r2, ca) where
    {ul
      {- r1 = round (s_min / s_max × 100)}
      {- r2 = round (s_mid / s_max × 100)}
      {- ca = round ((cos_max_angle + 1) × 100)}
    }
    with s_min ≤ s_mid ≤ s_max the sorted side lengths and
    cos_max_angle the cosine of the angle opposite the longest side. *)
val triangle_shape_key : point -> point -> point -> int * int * int

(** [procrustes_2d src dst] returns the similarity transform T that
    minimises Σ‖T(src_i) − dst_i‖².  Returns [None] when fewer than
    two correspondence pairs are given.

    Uses the closed-form 2-D solution (no SVD required). *)
val procrustes_2d : point array -> point array -> transform option

(** [rmsd t src dst] is the root-mean-square residual
    √(Σ‖T(src_i) − dst_i‖² / n). *)
val rmsd : transform -> point array -> point array -> float
