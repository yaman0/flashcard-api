class CardsController < ApplicationController
  before_action :set_collection
  before_action :set_collection_card, only: [:show, :update, :destroy]

  # GET /collections/:collection_id/cards
  def index
    json_response(@collection.cards)
  end

  # GET /collections/:collection_id/cards/:id
  def show
    json_response(@card)
  end

  # POST /collections/:collection_id/cards
  def create
    @collection.cards.create!(card_params)
    json_response(@collection, :created)
  end

  # PUT /collections/:collection_id/cards/:id
  def update
    @card.update(card_params)
    head :no_content
  end

  # DELETE /collections/:collection_id/cards/:id
  def destroy
    @card.destroy
    head :no_content
  end

  private

  def card_params
    params.permit(:front, :back)
  end

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def set_collection_card
    @card = @collection.cards.find_by!(id: params[:id]) if @collection
  end
end
