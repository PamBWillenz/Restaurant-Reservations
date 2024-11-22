class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.includes(:table)
                          .where('start_time >= ?', Time.current)
                          .order(start_time: :asc)
    @reservation = Reservation.new
  end

  def create
    @reservation = ReservationService.new(reservation_params).create_reservation

    if @reservation.persisted?
      redirect_to reservations_path, notice: "Reservation was successfully created."
    else
      @reservations = Reservation.includes(:table)
                            .where('start_time >= ?', Time.current)
                            .order(start_time: :asc)
      render :index, status: :unprocessable_entity
    end
  end
  
  private

  def reservation_params
    params.require(:reservation).permit(:name, :phone, :party_size, :start_time, :table_id)
  end
end
