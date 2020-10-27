class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index
  before_action :set_item
  before_action :sold_out

  def index
    @purchase = UserPurchase.new
  end

  def create
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:user_purchase).permit(:postal_code, :prefecture_id, :city, :house_number, :building, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path if current_user.id == Item.find(params[:item_id]).user.id
  end

  def sold_out
    redirect_to root_path if Purchase.exists?(item_id: params[:item_id])
  end
end
