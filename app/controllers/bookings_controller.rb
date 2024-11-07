class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]
  def index
    @bookings = current_user.bookings
    @superpowers = current_user.superpowers
    @my_booking_requests = @superpowers.map(&:bookings).flatten
  end

  def new
    @bookings = Booking.new
  end

  def show
    @booking
  end

  def create
    set_superpower
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.superpower = @superpower

    rental_days = (@booking.end_date - @booking.start_date).to_i
    total_price = rental_days * @superpower.renting_price

    if current_user.credits >= total_price
      # @booking.total_price = total_price 
      if @booking.save
        redirect_to bookings_path, notice: "Booking created successfully. Total amount: $#{total_price}"
      else
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "Not enough credits to book this superpower"
      redirect_to superpower_path(@superpower)
    end
  end

  def edit
    @booking
  end

  def update
    if booking_params[:status] == "accepted" && @booking.update(booking_params)
      transfer_credits
      redirect_to bookings_path, notice: "Booking accepted, and credits transferred successfully."
    elsif @booking.update(booking_params)
      redirect_to bookings_path, notice: "Booking updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bookings.destroy
    redirect_to bookings_path
  end

  private

  def transfer_credits
    if @booking.status == "accepted"
      rental_days = (@booking.end_date - @booking.start_date).to_i
      total_price = rental_days * @booking.superpower.renting_price
  
      if current_user.credits >= total_price
        ActiveRecord::Base.transaction do
          current_user.update!(credits: current_user.credits - total_price)
          @booking.superpower.user.update!(credits: @booking.superpower.user.credits + total_price)
        end
      else
        flash[:alert] = "Not enough credits for this transaction!."
        redirect_to bookings_path
      end
    end
  end

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
