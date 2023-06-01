class RentingsController < ApplicationController
  before_action :authenticate_user!
  # include Pundit::Authorization

  def new
    @product = Product.find(params[:product_id])
    @reservation = Renting.new
    authorize @product
  end

  def create
    @product = Product.find(params[:product_id])
    @renting = @product.reservations.new(reservation_params)
    if @renting.save
      redirect_to @product, notice: 'Reservation was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @renting = Renting.find(params[:id])
    @renting.destroy
    redirect_to rentings_path, notice: 'Reservation was successfully deleted.'
  end

  def edit
    @product = Product.find(params[:product_id])
    @renting = Renting.find(params[:id])
  end

  def update
    @product = Product.find(params[:product_id])
    @renting = Renting.find(params[:id])
    if @renting.update(renting_params)
      redirect_to @product, notice: 'Reservation was successfully updated.'
    else
      render :edit
    end
  end

  private

  def renting_params
    params.require(:renting).permit() # Adjust the permitted attributes as needed
  end
end
