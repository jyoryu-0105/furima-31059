class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :sold_out, only: [:edit]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
    redirect_to action: :index unless @item.user_id == current_user.id
  end

  def update
    unless @item.update(item_params)
      render :edit
    end
  end

  def create
    @item = Item.new(item_params)
    unless @item.save
      render :new
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.user_id == current_user.id
      item.destroy
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :category_id, :price, :status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :details).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def sold_out
    redirect_to root_path if Purchase.exists?(item_id: params[:id])
  end
end
