require 'rails_helper'

RSpec.describe 'Items API', type: :request do
# Initialize the test data
  let!(:collection) {create(:collection)}
  let!(:cards) {create_list(:card, 20, collection_id: collection.id)}
  let(:collection_id) {collection.id}
  let(:id) {cards.first.id}

# Test suite for GET /collections/:collection_id/cards
  describe 'GET /collections/:collection_id/cards' do
    before {get "/collections/#{collection_id}/cards"}

    context 'when collection exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all collection cards' do
        expect(json.size).to eq(20)
      end
    end

    context 'when collection does not exist' do
      let(:collection_id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Collection/)
      end
    end
  end

# Test suite for GET /collections/:collection_id/cards/:id
  describe 'GET /collections/:collection_id/cards/:id' do
    before {get "/collections/#{collection_id}/cards/#{id}"}

    context 'when collection card exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the card' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when collection card does not exist' do
      let(:id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Card/)
      end
    end
  end

# Test suite for POST /collections/:collection_id/cards
  describe 'POST /collections/:collection_id/cards' do
    let(:valid_attributes) {{front: 'Visit Narnia', back: 'Visit Narnia'}}

    context 'when request attributes are valid' do
      before {post "/collections/#{collection_id}/cards", params: valid_attributes}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before {post "/collections/#{collection_id}/cards", params: {}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Front can't be blank/)
      end
    end
  end

# Test suite for PUT /collections/:collection_id/cards/:id
  describe 'PUT /collections/:collection_id/cards/:id' do
    let(:valid_attributes) {{front: 'Mozart', back: 'Mozart'}}

    before {put "/collections/#{collection_id}/cards/#{id}", params: valid_attributes}

    context 'when card exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the card' do
        updated_card = Card.find(id)
        expect(updated_card.back).to match(/Mozart/)
        expect(updated_card.front).to match(/Mozart/)
      end
    end

    context 'when the card does not exist' do
      let(:id) {0}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Card/)
      end
    end
  end

# Test suite for DELETE /collections/:id
  describe 'DELETE /collections/:id' do
    before {delete "/collections/#{collection_id}/cards/#{id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
