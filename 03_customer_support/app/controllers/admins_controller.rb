class AdminsController < ApplicationController
  before_action :check_if_admin
  before_action :set_admin, only: [:show, :update, :destroy]

  def index
    @admins = Admin.all.sort.reverse
  end

  def show
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      render :show, status: :created
    else
      render json: @admin.errors, status: :unprocessable_entity
      end
  end

  def destroy
    if @admin.destroy
      render :show, status: :ok
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  private

  def check_if_admin
    unless current_user.is_admin?
      render json: {"errors" => ["Inaccessible Resource"]}, status: :unauthorized
    end
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:email, :password)
  end
end