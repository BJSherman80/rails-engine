FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    price { Faker::Commerce.price}
    merchant
  end
end
