class ReservationService
  def initialize(params)
    @params = params
    @start_time = parse_start_time
    @party_size = params[:party_size].to_i
  end

  # Creates a new reservation with the provided parameters
  def create_reservation
    reservation = Reservation.new(@params.merge(start_time: @start_time, table_id: @params[:table_id]))
    if reservation.save
      reservation
    else
      # Add a custom error message if the table is not available
      if reservation.errors[:table].any?
        reservation.errors.add(:base, "No tables available for this party size at the requested time")
      end
      reservation
    end
  end

  private

  # Checks if the provided parameters are invalid
  def invalid_params?
    @start_time.nil? || @party_size < 1 || @party_size > 8
  end

  # Parses the start time from the provided parameters
  # Returns nil if the start_time parameter is not present or cannot be parsed
  def parse_start_time
    return nil unless @params[:start_time].present?
    Time.zone.parse(@params[:start_time]) rescue nil
  end
  # Parsing the start time means converting the start time from a string format 
  # (as it is typically received from user input) into a Time object that can be used
  # for date and time calculations within the application. 
  # This process involves interpreting the string according to a specific date and time format and creating a corresponding Time object. 
  # If the string cannot be interpreted as a valid date and time, the method returns nil.
end