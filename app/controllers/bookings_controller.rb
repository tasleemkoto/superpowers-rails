class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @user = current_user
  end

  def new
    @bookings = Booking.new
  end

  def show
    @bookings
  end

  def create
    @bookings = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def edit
    @booking
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end

  def destroy
    @bookings.destroy
    redirect_to bookings_path
  end

  private

  def set_booking
    @booking =bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:user_id, :start_date, :end_date)
  end
end
