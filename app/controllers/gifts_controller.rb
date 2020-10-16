class GiftsController < ApplicationController
  before_action :set_gift, only: :show

  def new
    # ProductService PORO (product_id: )
    # @product = Product.find(params[:product_id])
    @gift = Gift.new(gift_params)
  end

  def create
  #  GiftService PORO (child_name: , birthdate: , parent_name)
  end

  def show
  end

private

  def set_gift
    @gift = Gift.find_by(id: params[:id])
  end

  def gift_params
    params.require(:gift).permit(:product_id, :child_name, :birthdate, :parent_name, :message)
  end
end
