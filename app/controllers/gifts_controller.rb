class GiftsController < ApplicationController
  before_action :set_gift, only: :show

  def new
    @gift = Gift.new(gift_params)
  end

  def create
    result = BuildGiftService.call(child_attributes, gifter_attributes, gift_attributes)
    raise result.error if result.is_a?(Failure)

    gift = result.object

    if gift.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
  end

  private

  def set_gift
    @gift ||= Gift.find(params[:id])
  end

  def child_attributes
    child_params[:child].to_hash
  end

  def gifter_attributes
    gifter_params[:gifter].to_hash
  end

  def gift_attributes
    gift_params.to_hash
  end

  def gift_params
    params.require(:gift).permit(:product_id, :message)
  end

  def child_params
    params.require(:gift).permit(child: [:full_name, :birthdate, :parent_name])
  end

  def gifter_params
    params.require(:gift).permit(gifter: [:first_name, :last_name, :email])
  end
end
