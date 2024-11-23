class ReservationService
  def initialize(params)
    @params = params
    @start_time = parse_start_time
    @party_size = params[:party_size].to_i
  end

  def create_reservation
    reservation = Reservation.new(@params.merge(start_time: @start_time, table_id: @params[:table_id]))
    if reservation.save
      reservation
    else
      if reservation.errors[:table].any?
        reservation.errors.add(:base, "No tables available for this party size at the requested time")
      end
      reservation
    end
  end

  private

  def invalid_params?
    @start_time.nil? || @party_size < 1 || @party_size > 8
  end

  def parse_start_time
    return nil unless @params[:start_time].present?
    Time.zone.parse(@params[:start_time]) rescue nil
  end
end