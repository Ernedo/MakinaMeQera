class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :set_car_list, only: [:edit, :new]
  before_action :set_client_list, only: [:edit, :new]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user.admin?
      @reservations = Reservation.all
    else
      @reservations = Reservation.where(user_id: current_user.id)
    end
  end

  def show
  end

  def edit
  end

  def new
    @reservation = Reservation.new
  end

  def create
    Rails.logger.info "Params: #{reservation_params}"
    @reservation = Reservation.new(reservation_params)
    @reservation.assign_attributes(car_id: params["car_id"], client_id: params["client_id"], user_id: current_user.id)
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation successfully created ' }
      else
        set_car_list
        set_client_list
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated ' }
      else
        set_car_list
        set_client_list
        format.html { render :edit }
      end
    end
  end

  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was destroyed' }
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_car_list
    @car_list = Car.where(deleted_at: nil)
  end

  def set_client_list
    @client_list = Client.all
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :price)
  end

end
