class UsersController < ApplicationController

  def edit
  end

  def show
  @user = User.find(params[:id])
  @items = @user.items.order('created_at DESC')
  end

  def update
  end

  private

end
