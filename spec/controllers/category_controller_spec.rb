require 'rails_helper'
include Jwt
RSpec.describe CategoriesController, type: :request do
  let(:token_permission) do
    @user = FactoryBot.create(:user)
    jwt_encode(user_id: @user.id)
  end
  
  describe 'GET /categories INDEX' do
    context 'Authenticated' do
      context 'There is no data' do
        it 'Return a empty array' do
          get '/categories', headers: { 'Authorization': token_permission }
          expect(response).to have_http_status(200)
          expect_json([])
        end
      end
      context 'There is some data' do
        before(:each) do
          @categories = []
          5.times do
            @categories << FactoryBot.create(:category)
          end
        end
        it 'Return all data' do
          get '/categories', headers: { 'Authorization': token_permission }
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body).length).to eq(@categories.length)
        end
      end
    end
    context 'Not Authenticated' do
      it 'Return unauthorized' do
        get '/categories'
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /categories/:id SHOW' do
    context 'Authenticated' do
      context 'There is no data' do
        it 'Return a empty array' do
          get '/categories/0', headers: { 'Authorization': token_permission }
          expect(response).to have_http_status(404)
        end
      end
      context 'There is some data' do
        it 'Return all data' do
          FactoryBot.create(:category)
          category = FactoryBot.create(:category)
          get "/categories/#{category.id}", headers: { 'Authorization': token_permission }

          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body).length).to eq(2)
          expect(JSON.parse(response.body)['name']).to eq(category.name)
          expect(JSON.parse(response.body)['id']).to eq(category.id)
        end
      end
    end
    context 'Not Authenticated' do
      it 'Return unauthorized' do
        get '/categories/1'
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /categories CREATE' do
    context 'Authenticated' do
      context 'All input data is correct' do
        it 'Save and return data' do
          expect do
            post '/categories', params: { name: 'new category' }, headers: { 'Authorization': token_permission }
          end.to change { Category.count }.by(1)
          expect(response).to have_http_status(201)
          expect(JSON.parse(response.body)['name']).to eq('New category')
        end
      end
      context 'When name already exist' do
        it 'Dont save data and return a error message' do
          FactoryBot.create(:category, name: 'article')
          expect do # rubocop:disable Lint/AmbiguousBlockAssociation
            post '/categories', params: { name: 'article' }, headers: { 'Authorization': token_permission }
          end.to_not change { Category.count }
          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['name']).to eq(['This name has already been taken'])
        end
      end
      context 'When name is blank' do
        it 'Dont save data and return a error message' do
          expect do # rubocop:disable Lint/AmbiguousBlockAssociation
            post '/categories', params: { name: '' }, headers: { 'Authorization': token_permission }
          end.to_not change { Category.count }
          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['name']).to eq(["The name can't be blank"])
        end
      end
    end
    context 'Not authenticated' do
      it 'Return unauthorized' do
        post '/categories', params: { name: 'aaa' }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /categories/:id UPDATE' do
    context 'Authenticated' do
      before(:each) do
        @category1 = FactoryBot.create(:category)
        @category2 = FactoryBot.create(:category)
      end
      context 'Update name with correct data' do
        it 'Updates category name' do
          expect do # rubocop:disable Lint/AmbiguousBlockAssociation
            put "/categories/#{@category1.id}", params: { name: 'new category' }, headers: { 'Authorization': token_permission }
          end.to_not change { Category.count }
          expect(JSON.parse(response.body)['name']).to eq('New category')  
        end
      end
      context 'Updates the name to an already existing name' do
        it 'Dont change the name and raise an error message' do
          expect do # rubocop:disable Lint/AmbiguousBlockAssociation
            put "/categories/#{@category2.id}", params: { name: @category1.name }, headers: { 'Authorization': token_permission }
          end.to_not change { Category.count }
          expect(response).to have_http_status(422) 
        end
      end
      context 'There is no data' do
        it 'Return an error message ' do
          put '/categories/0', headers: { 'Authorization': token_permission }
          expect(response).to have_http_status(404)
          expect(JSON.parse(response.body)['not_found']).to eq("Couldn't find Category with 'id'=0")  
        end
      end
    end
    context 'Not authenticated' do
      it 'Return unauthorized' do
        put '/categories/1', params: { name: 'aaa' }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /categories/:id DESTROY' do
    context 'Authenticated' do
      context 'There is a match data to delete' do
        it 'Delete data' do
          category = FactoryBot.create(:category)
          expect do
            delete "/categories/#{category.id}", headers: { 'Authorization': token_permission }
          end.to change { Category.count }.by(-1)
          expect(response).to have_http_status(200)  
        end
      end
      context 'There is no match data to delete' do
        it 'Return status 404'do
          delete '/categories/0', headers: { 'Authorization': token_permission }
          expect(response).to have_http_status(404)
          expect(JSON.parse(response.body)['not_found']).to eq("Couldn't find Category with 'id'=0")  
        end
      end
    end
    context 'Not Authenticated' do
      it 'Return unauthorized' do
        delete '/categories/1'
        expect(response).to have_http_status(401)
      end
    end
  end
end
