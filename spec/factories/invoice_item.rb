require 'faker'
FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
