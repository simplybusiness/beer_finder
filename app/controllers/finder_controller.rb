class FinderController < ApplicationController
  def index
    @outlets = OutletRepository.get_outlets
  end

end
