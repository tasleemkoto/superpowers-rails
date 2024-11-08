class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]
  def index
    @bookings = current_user.bookings
    @superpowers = current_user.superpowers
    booking_requests = @superpowers.map(&:bookings).flatten
    @my_booking_requests = booking_requests.select { |booking| booking.status == "pending" }
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
    if @booking.update(booking_params)
      if booking_params[:status] == "accepted" 
        transfer_credits
        redirect_to bookings_path, notice: "Booking accepted, and credits transferred successfully."
      else
         redirect_to bookings_path, notice: "Booking rejected!"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def transfer_credits
    rental_days = (@booking.end_date - @booking.start_date).to_i
    total_price = rental_days * @booking.superpower.renting_price
    puts "Rental days: #{rental_days}, Total price: #{total_price}"
    puts "Current user credits before transfer: #{current_user.credits}"
    if current_user.credits >= total_price
        current_user_credits = current_user.credits + total_price
        current_user.update(credits: current_user_credits)
        puts "Current user credits after transfer: #{current_user.reload.credits}"
        testi = @booking.user.credits - total_price
        @booking.user.update(credits: testi)
        puts "Superpower owner credits after transfer: #{@booking.user.reload.credits}"
    else
        puts "Not enough credits to transfer."
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
