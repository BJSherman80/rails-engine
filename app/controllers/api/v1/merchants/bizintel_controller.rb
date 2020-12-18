
class Api::V1::Merchants::BizintelController < ApplicationController

  def most_revenue
    render json: MerchantSerializer.new(MerchantFacade.most_revenue(params[:quantity]))
  end

  def most_items
    render json: MerchantSerializer.new(MerchantFacade.most_items(params[:quantity]))
  end

  def merchant_revenue
    render json: RevenueSerializer.new(MerchantFacade.merchant_revenue(params[:id]))
  end

  # def revenue_within_dates
  #   render json: RevenueSerializer.new(MerchantFacade.revenue_within_dates(params[:i))
  # end

end
