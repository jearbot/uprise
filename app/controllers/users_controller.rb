class UsersController < ApplicationController
  def index
    @users = User.all.order(name: :asc).page(params[:page])
  end

  def create
    begin
      User.create!(create_params)
      flash[:success] = "User created successfully"
    rescue StandardError => e
      flash[:alert] = e.message
    end

    redirect_to action: :index
  end

  def update
    begin
      user = User.find(params[:id])
      user.update!(update_params)
      flash[:success] = "User updated successfully"
    rescue StandardError => e
      flash[:alert] = e.message
    end

    redirect_to action: :index
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy!
      flash[:success] = "User destroyed successfully"
    rescue StandardError => e
      flash[:alert] = e.message
    end

    redirect_to action: :index
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def create_params
    params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :email, :phone_number)
  end
end
