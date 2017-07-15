class CustomersController < ApplicationController
  before_action :check_if_admin

  before_action :set_customer, only: :show

  def index
    @customers = Customer.all
  end

  def show
  end

  private

  def check_if_admin
    unless current_users.is_admin?
      render json: { "errors" => ["Inaccessible Resource"]},
             status: :unauthorized
      return
    end
  end

  def check_if_admin_or_self
    unless current_user.is_admin? or current_user == @customer
      render json: { "errors" => ["Inaccessible Resource"]},
             status: :unauthorized
      return
    end
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end