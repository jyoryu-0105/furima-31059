class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def show
  end
  
  def edit
    
  end

  def update
    
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :category_id, :price, :status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :details).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
