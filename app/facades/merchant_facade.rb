class MerchantFacade

  def self.most_revenue(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(quantity * unit_price) as revenue")
    .where("transactions.result='success' AND invoices.status='shipped'")
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(invoice_items.quantity) as total")
    .where("transactions.result='success' AND invoices.status='shipped'")
    .group(:id)
    .order("total DESC")
    .limit(quantity)
  end

  def self.merchant_revenue(id)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .where("transactions.result='success' AND invoices.status='shipped'")
    .where("merchants.id = #{id}")
    .group(:id).first
  end

  def self.revenue_within_dates(params)
   Invoice.select("SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(:invoice_items, :transactions)
    .where("transactions.result='success' AND invoices.status='shipped'")
    .where("invoices.created_at '#{params[:start]} 00:00:00' and ''#{params[:end]} 23:59:59'")
  end
end
