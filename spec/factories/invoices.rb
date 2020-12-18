FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { %w[shipped packaged].sample }
  end
end
