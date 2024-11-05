class SuperpowersController < ApplicationController
  def index
    @superpowers = Superpower.all
  end
  def new
    @superpower = Superpower.new
  end
  def show
    @superpower = Superpower.find(params[:id])
    @booking = Booking.new
  end
  def create

  end

  def update
    @superpower = Superpower.find(params[:id])
    if @superpower.update(superpower_params)
      redirect_to @superpower, notice: "Superpower successfully updated!"
    else
      render :edit
    end
  end

  def edit
    @superpower = Superpower.find(params[:id])
  end

  def destroy
    @superpower = Superpower.find(params[:id])
    @superpower.destroy
    redirect_to superpowers_path, notice: "Superpower was successfully deleted."
  end

  def rent
    @superpower = Superpower.find(params[:id])
    redirect_to @superpower, notice: "You have successfully rented this superpower!"
  end

  def buy
    @superpower = Superpower.find(params[:id])
    redirect_to @superpower, notice: "You have successfully purchased this superpower!"
  end
end
