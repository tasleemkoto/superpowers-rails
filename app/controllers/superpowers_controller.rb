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
    
  end

  def edit
    
  end

  def destroy
    
  end
end
