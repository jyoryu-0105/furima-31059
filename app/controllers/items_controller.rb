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

  private
  def item_params
    params.require(:item).permit(:name, :price, :details).merge(user_id: current_user.id)
  end
end
