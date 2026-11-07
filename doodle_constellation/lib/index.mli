(** Geometric-hashing index over star triangles.

    The index maps rotation-, scale-, and translation-invariant shape
    keys (integer triples) to lists of ordered star triples that produce
    that key.  The key is computed by [Geometry.triangle_shape_key].

    Building the index is an O(n³) offline step where n is the number of
    catalogue stars; for a 60-star catalogue this is negligible.

    Reference: Lamdan, Schwartz & Wolfson (1988) "Object recognition by
    affine invariant matching". *)

(** An opaque index value. *)
type t

(** [build ~stars ~max_sep_deg] builds an index from [stars].  Only
    triangles whose longest side spans less than [max_sep_deg] degrees
    are indexed (restricts matches to compact patterns on the sky).

    Typical value: [max_sep_deg] ≈ 25.0. *)
val build : stars:Star.t array -> max_sep_deg:float -> t

(** [lookup ~key idx] returns all star triples stored under [key], and
    also under the 26 adjacent bin keys (one-step tolerance on each
    dimension) to absorb drawing imprecision.

    The returned list may contain duplicates when different bin offsets
    hit the same triple; callers should deduplicate if needed. *)
val lookup : key:(int * int * int) -> t -> (Star.t * Star.t * Star.t * float * float) list

(** [entry_count idx] is the total number of (key, triple) pairs stored. *)
val entry_count : t -> int
