class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :update, :destroy]

  # GET /collections
  def index
    @collections = current_user.collections
    json_response(@collections)
  end

  # POST /collections
  def create
    @collection = current_user.collections.create!(collection_params)
    @collection.favorite = false
    json_response(@collection, :created)
  end

  # GET /collections/:id
  def show
    json_response(@collection)
  end

  # PUT /collections/:id
  def update
    @collection.update(collection_params)
    head :no_content
  end

  # DELETE /collections/:id
  def destroy
    @collection.destroy
    head :no_content
  end

  private

  def collection_params
    # whitelist params
    params.permit(:title)
  end

  def set_collection
    @collection = Collection.find(params[:id])
  end
end
