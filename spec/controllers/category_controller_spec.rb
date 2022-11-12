require 'rails_helper'

RSpec.describe 'Requests interessados', type: :request do
  describe 'GET /categories INDEX' do
    context 'There is no data' do
      it 'Return a empty array' do
        get '/categories', xhr: true
        expect(response).to have_http_status(200)
        expect_json([])
      end
    end
  end
end
