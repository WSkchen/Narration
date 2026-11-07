(** Star catalogue: a fixed collection of naked-eye stars.

    The embedded catalogue is derived from the Yale Bright Star Catalogue
    (Hoffleit & Jaschek, 1991), trimmed to stars with apparent magnitude
    ≤ 3.5.  All positions are J2000.0. *)

(** A compiled star catalogue (immutable). *)
type t

(** [default] is the built-in catalogue of ~60 naked-eye stars (mag ≤ 3.5). *)
val default : t

(** [stars cat] returns all stars in [cat] as an array. *)
val stars : t -> Star.t array

(** [filter_magnitude ~max_mag cat] returns a new catalogue containing
    only stars with apparent magnitude ≤ [max_mag]. *)
val filter_magnitude : max_mag:float -> t -> t

(** [size cat] is the number of stars in [cat]. *)
val size : t -> int

(** [find_name name cat] returns the first star whose name equals [name]
    (case-insensitive), or [None]. *)
val find_name : string -> t -> Star.t option

(** [nearest_projected ~pt stars] returns the star in [stars] that is
    closest (in Euclidean distance) to [pt] in the tangent plane, together
    with that distance.  [stars] must be an array of [(Star.t, Geometry.point)]
    pairs that have already been projected.  Returns [None] if the array
    is empty. *)
val nearest_projected
  :  pt:Geometry.point
  -> (Star.t * Geometry.point) array
  -> (Star.t * float) option
