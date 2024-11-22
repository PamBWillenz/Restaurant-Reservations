class ReservationService
  def initialize(params)
    @params = params
    @start_time = parse_start_time
    @party_size = params[:party_size].to_i
  end

  def create_reservation
    return Reservation.new(@params) if invalid_params?

    available_table = find_available_table
    if available_table
      Reservation.create(@params.merge(start_time: @start_time, table: available_table))
    else
      reservation = Reservation.new(@params)
      reservation.errors.add(:table, "is not available at that time")
      reservation
    end
  end

  private

  def invalid_params?
    @start_time.nil? || @party_size < 1 || @party_size > 8
  end

  def parse_start_time
    return nil unless @params[:start_time].present?
    Time.zone.parse(@params[:start_time])
  end

  # need to find a table that is available at the start time and can accommodate the party size and is not overlapping with another reservation
  def find_available_table
    Table.all.each do |table|
      return table if table.available?(@start_time, @party_size)
    end
    nil
  end
end