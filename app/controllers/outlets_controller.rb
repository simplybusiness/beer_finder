class OutletsController < ApplicationController
  def index
    outlets = OutletRepository.get_outlets

    render json: { "outlets" => outlets }
  end
end
