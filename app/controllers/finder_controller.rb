class FinderController < ApplicationController
  def index
    postcode = finder_params['postcode']
    @outlets = OutletRepository.get_outlets(postcode)
  end

  private

  def finder_params
    params.permit(:postcode)
  end
end
