class GuestsController < ApplicationController
  respond_to :json

  def index
    respond_to do |format|
      format.json { render json: Guest.all }
      format.html
    end
  end

  def create
    respond_with Guest.create(guest_params)
  end

  def destroy
    respond_with Guest.destroy(params[:id])
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :reason)
  end
end
