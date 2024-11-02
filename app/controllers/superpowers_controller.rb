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
    
  end

  def edit
    
  end

  def destroy
    
  end

  private

  def superpower_params
    params.require(:superpower).permit(:title, :description, :price, :category, :current_user)
  end
end
