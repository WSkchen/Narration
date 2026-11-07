(** Visibility calculator.

    Converts a matched sky region's equatorial coordinates to the
    horizontal coordinate system (altitude, azimuth) for a given
    observer location and date, and finds the best viewing time tonight.

    The calculations use the standard formulas for local sidereal time
    and hour angle; they are accurate to within a few minutes for the
    present epoch and do not need a full planetary ephemeris. *)

(** Observer location on Earth. *)
type location = {
  lat_deg : float;   (** geodetic latitude, degrees north *)
  lon_deg : float;   (** longitude, degrees east (west is negative) *)
}

(** Altitude and azimuth in the horizontal coordinate system. *)
type altaz = {
  alt_deg : float;   (** altitude above the horizon, degrees *)
  az_deg  : float;   (** azimuth from north, degrees clockwise *)
}

(** A summary of when and where to find a sky region tonight. *)
type viewing_info = {
  culmination_hour : float;
  (** Local solar hour (0–24) of culmination (transit across the meridian). *)
  alt_at_midnight  : altaz;
  (** Altitude/azimuth at local midnight. *)
  is_dark          : bool;
  (** [true] if the culmination occurs during astronomical darkness
      (at least 1.5 h after sunset and before sunrise for the given date
      and latitude — a rough approximation). *)
}

(** [new_york] is a convenience location for New York City. *)
val new_york : location

(** [compute ~ra ~dec ~loc ~day_of_year] returns viewing information for
    the sky region centred at ([ra],[dec]) degrees, as seen from [loc]
    on the [day_of_year]-th day of the year (1 = 1 Jan). *)
val compute
  :  ra          : float
  -> dec         : float
  -> loc         : location
  -> day_of_year : int
  -> viewing_info
