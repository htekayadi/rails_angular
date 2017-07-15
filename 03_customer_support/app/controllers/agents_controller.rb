class AgentsController < ApplicationController
  before_action :check_if_agent
  before_action :set_agent, only: [:show, :update, :destroy]

  def index
    @agents = Agent.all.sort
  end

  def show
  end

  def create
    @agent = Agent.new(agent_params)

    if @agent.save
      render :show, status: :created
    else
      render json: @agent.errors, status: :unprocessable_entity
      end
  end

  def destroy
    if @agent.destroy
      render :show, status: :ok
    else
      render json: @agent.errors, status: :unprocessable_entity
    end
  end

  private

  def check_if_agent
    unless current_user.is_agent?
      render json: {"errors" => ["Inaccessible Resource"]},
        status: :unauthorized
    end
  end

  def set_agent
    @agent = Agent.find(params[:id])
  end

  def agent_params
    params.require(:agent).permit(:email, :password)
  end
end