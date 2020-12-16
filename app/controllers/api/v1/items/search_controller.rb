class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.where('name ilike ?', "%#{params[:name]}%")
    render json: ItemSerializer.new(items)
  end

  def show
    items = Item.find_by('name ilike ?', "%#{params[:name]}%")
    render json: ItemSerializer.new(items)
  end
end
