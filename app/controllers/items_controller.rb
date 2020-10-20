class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path(@item)
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :category_id, :price, :status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :details).merge(user_id: current_user.id)
  end
end
