class SupportRequestsController < ApplicationController
  before_action :check_if_customer, only: :create
  before_action :check_and_set_support, only: [:show, :update]

  def index
    if params[:report].blank?
      if current_user.is_admin?
        @support_requests = SupportRequest.all
      elsif current_user.is_an_agent?
        # If the requesting user is an agent, get all the open support requests assigned to this agent
        @support_requests = current_user.open_support_requests
      elsif current_user.is_a_customer?
        # If the requesting user is a customer, get the support requests created by the customer
        @support_requests = current_user.support_requests
      end

      @support_requests = @support_requests.includes(:agent, :customer).sort.reverse

    else
      if current_user.is_admin? or current_user.is_an_agent?
        @support_requests = SupportRequest.where(status: "closed").where("closed_at >=", 1.month.ago).includes(:agent, :customer).sort

        respond_to do |format|
          format.pdf {
            send_file Report.generate, :filename => "report.pdf", :type => "application/pdf", :disposition => "attachment"
          }
          format.json {
            render "support_requests/index"
          }
        end
      else
        render json { "errors" => ["Inaccessible Resource"]}, status: :unauthorized
        return
      end
    end
  end

  def show

  end

  def create
    @support_request = SupportRequest.new(support_request_params)
    @support_request.customer = current_user

    if @support_request.save
      render :show, status: :created
    else
      render json: @support_request.errors, status: :unprocessable_entity
    end
  end

  def update
    if @support_request.update(support_request_params)
      render :show, status: :ok
    else
      render json: @support_request.errors, status: unprocessable_entity
    end
  end

  private

  def check_and_set_support_request
    @support_request = SupportRequest.find(params[:id])

    unless current_user.is_admin? or @support_request.in? current_user.support_requests
      render json: { "errors" => ["Inaccessible Resource"]}, status: :unauthorized
      return
    end
  end

  def check_if_customer
    unless current_user.is_a_customer?
      render json: { "errors" => ["Inaccessible Resource"]}, status: :unauthorized
      return
    end
  end

  def support_request_params
    params.require(:support_request).permit(:subject, :description, :status, :severity, :category)
  end
end
