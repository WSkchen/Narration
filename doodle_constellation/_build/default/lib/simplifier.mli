(** Stroke simplifier — Ramer–Douglas–Peucker algorithm.

    Reduces a dense list of pointer positions to a small set of corner
    points that faithfully represent the shape of the stroke.

    Reference: Ramer (1972) "An iterative procedure for the polygonal
    approximation of plane curves"; Douglas & Peucker (1973) "Algorithms
    for the reduction of the number of points required to represent a
    digitized line or its caricature". *)

(** A raw stroke point.  Coordinates are in arbitrary screen units. *)
type raw_point = float * float

(** [simplify ~epsilon pts] reduces [pts] to the smallest subsequence
    such that every omitted point lies within [epsilon] of the
    simplified polyline.  The first and last points are always kept.

    Raises [Invalid_argument] if [pts] is empty.

    Typical values: [epsilon] ≈ 2–8 screen pixels for a finger drawing. *)
val simplify : epsilon:float -> raw_point list -> raw_point list

(** [corner_count pts] is the length of [pts]; a convenience alias. *)
val corner_count : raw_point list -> int

(** [is_valid ~min_corners ~max_corners pts] is [true] when the number
    of corners lies in the inclusive range [[min_corners, max_corners]].
    Shapes outside that range (too simple or too complex to match a
    small star group) are rejected before the index lookup. *)
val is_valid : min_corners:int -> max_corners:int -> raw_point list -> bool
