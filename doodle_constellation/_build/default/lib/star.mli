(** A single star from the catalogue.

    Coordinates use the equatorial system: right ascension ([ra]) and
    declination ([dec]) in decimal degrees, epoch J2000.  Apparent
    magnitude ([mag]) follows the standard scale where smaller numbers
    are brighter (Sirius ≈ -1.46; unaided-eye limit ≈ +6). *)

type t = {
  name         : string;
  ra           : float;   (** right ascension, degrees, J2000 *)
  dec          : float;   (** declination, degrees, J2000 *)
  mag          : float;   (** apparent magnitude *)
  constellation: string;
}

(** [angular_distance a b] is the great-circle angular separation between
    stars [a] and [b], in degrees.  Uses the haversine formula to avoid
    rounding errors near 0°. *)
val angular_distance : t -> t -> float

(** [pp ppf s] pretty-prints star [s] on formatter [ppf]. *)
val pp : Format.formatter -> t -> unit
