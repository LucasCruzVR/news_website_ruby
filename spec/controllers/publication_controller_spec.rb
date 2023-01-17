require 'rails_helper'
include Jwt
RSpec.describe PublicationsController, type: :request do
  let(:token_permission) do
    @user = FactoryBot.create(:user)
    jwt_encode(user_id: @user.id)
  end

  describe 'GET /publications INDEX' do
    context 'There is no data' do
      it 'Return a empty array' do
        get '/publications', headers: { 'Authorization': token_permission }
        expect(response).to have_http_status(200)
        expect_json([])
      end
    end
    context 'There is some data' do
      before(:each) do
        @publications = []
        5.times do
          @publications << FactoryBot.create(:publication)
        end
      end
      it 'Return all data' do
        get '/publications', headers: { 'Authorization': token_permission }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).length).to eq(@publications.length)
      end
    end
  end

  describe 'GET /publications/:id SHOW' do
    context 'There is no data' do
      it 'Return a empty array' do
        get '/publications/0', headers: { 'Authorization': token_permission }
        expect(response).to have_http_status(404)
      end
    end
    context 'There is some data' do
      it 'Return all data' do
        FactoryBot.create(:publication)
        publication = FactoryBot.create(:publication)
        get "/publications/#{publication.id}", headers: { 'Authorization': token_permission }

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).length).to eq(7)
        expect(JSON.parse(response.body)['title']).to eq(publication.title)
        expect(JSON.parse(response.body)['id']).to eq(publication.id)
      end
    end
  end

  describe 'POST /publications CREATE' do
    context 'All input data is correct' do
      it 'Save and return data' do
        category = FactoryBot.create(:category)
        publication_attributes = FactoryBot.attributes_for(:publication, category_id: category.id)
        expect do
          post '/publications', params: publication_attributes, headers: { 'Authorization': token_permission }
        end.to change { Publication.count }.by(1)
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['title']).to eq(publication_attributes[:title])
      end
    end
    context 'When name already exist' do
      it 'Dont save data and return a error message' do
        FactoryBot.create(:publication, title: 'article')
        publication_attributes = FactoryBot.attributes_for(:publication, title: 'article')
        expect do # rubocop:disable Lint/AmbiguousBlockAssociation
          post '/publications', params: publication_attributes, headers: { 'Authorization': token_permission }
        end.to_not change { Publication.count }
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['title']).to eq(['This title has already been taken'])
      end
    end
    context 'When name is blank' do
      it 'Dont save data and return a error message' do
        expect do # rubocop:disable Lint/AmbiguousBlockAssociation
          post '/publications', params: { name: '' }, headers: { 'Authorization': token_permission }
        end.to_not change { Publication.count }
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['title']).to eq(["The title can't be blank"])
      end
    end
  end

  describe 'PUT /publications/:id UPDATE' do
    before(:each) do
      @publication1 = FactoryBot.create(:publication)
      @publication2 = FactoryBot.create(:publication)
    end
    context 'Update title with correct data' do
      it 'Updates publication title' do
        expect do # rubocop:disable Lint/AmbiguousBlockAssociation
          put "/publications/#{@publication1.id}", params: { title: 'new title' }, headers: { 'Authorization': token_permission }
        end.to_not change { Publication.count }
        expect(JSON.parse(response.body)['title']).to eq('new title')
      end
    end
    context 'Updates the name to an already existing name' do
      it 'Dont change the name and raise an error message' do
        expect do # rubocop:disable Lint/AmbiguousBlockAssociation
          put "/publications/#{@publication2.id}", params: { title: @publication1.title }, headers: { 'Authorization': token_permission }
        end.to_not change { Publication.count }
        expect(response).to have_http_status(422)
      end
    end
    context 'There is no data' do
      it 'Return an error message ' do
        get '/publications/0', headers: { 'Authorization': token_permission }
        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)['not_found']).to eq("Couldn't find Publication with 'id'=0")
      end
    end
  end

  describe 'DELETE /publications/:id DESTROY' do
    context 'There is a match data to delete' do
      it 'Delete data' do
        publication = FactoryBot.create(:publication)
        expect do
          delete "/publications/#{publication.id}", headers: { 'Authorization': token_permission }
        end.to change { Publication.count }.by(-1)
        expect(response).to have_http_status(200)
      end
    end
    context 'There is no match data to delete' do
      it 'Return status 404' do
        delete '/publications/0', headers: { 'Authorization': token_permission }
        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)['not_found']).to eq("Couldn't find Publication with 'id'=0")
      end
    end
  end
end
