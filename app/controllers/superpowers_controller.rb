class SuperpowersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @superpowers = Superpower.all
  end
  
  def new
    @user = User.current_user
    @superpower = Superpower.new
  end
  
  def show
    @superpower = Superpower.find(params[:id])
    @booking = Booking.new
  end
  
  def create
    @superpower = current_user.superpowers.build(superpower_params)
    if @superpower.save
      redirect_to @superpower, notice: "Superpower was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
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

  private

  def superpower_params
    params.require(:superpower).permit(:title, :description,:selling_price, :renting_price, :category, :current_user)
  end
end
