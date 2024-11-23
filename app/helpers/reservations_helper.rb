module ReservationsHelper
  def reservation_time(reservation)
    reservation.start_time.strftime("%l:%M %p").strip
  end

  def reservation_date(reservation)
    reservation.start_time.strftime("%B %e, %Y")
  end

  def reservation_date_and_time(reservation)
    "#{reservation_date(reservation)} at #{reservation_time(reservation)}"
  end
end