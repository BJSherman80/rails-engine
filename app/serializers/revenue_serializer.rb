class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :revenue do |object|
    object.revenue
  end
end
