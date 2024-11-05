class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
    @superpowers = current_user.superpowers
    @my_booking_requests = @superpowers.map(&:bookings).flatten
  end

  def new
    @bookings = Booking.new
  end

  def show
    @bookings
  end

  def create
    set_superpower
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.superpower = @superpower
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking
  end

  def update
    set_booking
    if @booking.update(booking_params)
      redirect_to bookings_path
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
    @booking = Booking.find(params[:id])
  end

  def set_superpower
    @superpower = Superpower.find(params[:superpower_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
