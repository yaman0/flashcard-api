require 'rails_helper'

RSpec.describe 'Collection API', type: :request do
  # initialize test data
  let!(:collections) { create_list(:collection, 10) }
  let(:collection_id) { collections.first.id }

  # Test suite for GET /collections
  describe 'GET /collections' do
    # make HTTP get request before each example
    before { get '/collections' }

    it 'returns collections' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /collections/:id
  describe 'GET /collections/:id' do
    before { get "/collections/#{collection_id}" }

    context 'when the record exists' do
      it 'returns the collection' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(collection_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:collection_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Collection/)
      end
    end
  end

  # Test suite for POST /collections
  describe 'POST /collections' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/collections', params: valid_attributes }

       it 'creates a collection' do
        expect(json['title']).to eq('Learn Elm')
        expect(json['created_by']).to eq('1')
        expect(json['favorite']).to eq(false)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/collections', params: { favorite: 'true'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /collections/:id
  describe 'PUT /collections/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/collections/#{collection_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /collections/:id
  describe 'DELETE /collections/:id' do
    before { delete "/collections/#{collection_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
