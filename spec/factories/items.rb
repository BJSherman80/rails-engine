FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    description {Faker::Hipster.sentences}
    unit_price { Faker::Number.decimal }
    merchant
  end
end
