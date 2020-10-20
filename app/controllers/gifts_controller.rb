class GiftsController < ApplicationController
  before_action :set_gift, only: :show

  def new
    @gift = Gift.new(gift_params)
    @order = Order.new(product_id: Product.find(gift_params[:product_id]))
  end

  def create
    result = BuildGiftService.call(child_attrs, gifter_attrs, gift_attrs, credit_card_attrs)
    raise result.error if result.is_a?(Failure)

    @gift = result.object

    if @gift.save
      redirect_to gift_path(@gift)
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

  def child_attrs
    child_params[:child].to_hash
  end

  def gifter_attrs
    gifter_params[:gifter].to_hash
  end

  def gift_attrs
    gift_params.to_hash
  end

  def credit_card_attrs
    credit_card_params[:card].to_hash
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

  def credit_card_params
    params.require(:gift).permit(card: [:credit_card_number, :expiration_month, :expiration_year])
  end
end
