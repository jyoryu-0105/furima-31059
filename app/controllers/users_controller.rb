class UsersController < ApplicationController

  def index
    @user = current_user
  end

  def show
  @user = User.find(params[:id])
  @items = @user.items.order('created_at DESC')
  end

end
