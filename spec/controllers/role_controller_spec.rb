require 'rails_helper'
include Jwt
Rspec.describe RolesController, type: :request do
    let(:token_permission) do
        @user = FactoryBot.create(:user)
        jwt_encode(user_id: @user.id)
    end

    describe 'GET /roles INDEX' do
        context 'Authenticated' do
            context 'There is no data' do
                it 'Return a empty array' do
                    get '/roles', headers: { 'Authorization': token_permission }
                    expect(response).to have_http_status(200)
                    expect_json([])
                end
            end
        end
        context 'Not authenticated' do
            context 'There is no data' do
                it 'Return unauthorized' do
                    get '/roles'
                    expect(response).to have_http_status(401)
                end
            end
        end
    end
end