class UsersController < ApplicationController
  def index
    @users = User.all.order(name: :asc).page(params[:page])
  end
end
