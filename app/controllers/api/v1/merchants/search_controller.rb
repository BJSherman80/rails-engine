class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Merchant.where('name ilike ?', "%#{params[:name]}%")
    render json: MerchantSerializer.new(merchants)
  end
  
  def show
    merchants = Merchant.find_by('name ilike ?', "%#{params[:name]}%")
    render json: MerchantSerializer.new(merchants)
  end
end
