# Handles requests to /api/users
class UsersController < ApplicationController
  before_action :set_user

  before_action :scheck_if_admin_or_self

  # GET /users/1
  def show

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_if_admin_or_self
    unless current_user.is_admin? or (current_user == @user)
      render json: {"errors" => ["Inaccessible Resource"]}, status: :unauthorized
    end
  end
end
