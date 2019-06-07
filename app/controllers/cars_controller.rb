class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @cars = Car.where(deleted_at: nil)
  end
  def show
  end
  def new
    @car = Car.new
  end
  def edit
  end
  def create
    @car = Car.new(car_params)
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }

      else
        format.html { render :new }

      end
    end
  end
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }

      else
        format.html { render :edit }

      end
    end
  end
  def destroy
        @car.update(deleted_at: Time.now)

        respond_to do |format|
          format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
    end
  end

  private

    def set_car
      @car = Car.find(params[:id])
    end


    def car_params
      params.require(:car).permit(:model, :mark, :price, :targa)
    end
end
