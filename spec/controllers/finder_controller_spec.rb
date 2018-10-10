require 'rails_helper'

RSpec.describe FinderController do
  describe 'Index' do
    it 'responds with 200 success' do
      expect(response.status).to be 200
    end
  end
end
