class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true, length: { allow_blank: false }
  validates :description, presence: true, length: { allow_blank: false }
  validates :unit_price, presence: true, numericality: {only_integer: false, greater_than: 0}
end
