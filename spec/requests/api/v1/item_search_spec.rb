
require 'rails_helper'

RSpec.describe "Item API search" do
  it "can get list of items when searching" do
    create(:item, name: "Kitten")
    create(:item, name: "Monster car")
    create(:item, name: "Truck car")
    create(:item, name: "Robot")

    get '/api/v1/items/find_all?name=car'

    expect(response).to be_successful

    car_items = JSON.parse(response.body, symbolize_names: true)
    expect(car_items).to be_a(Hash)
    results = car_items[:data]
    expect(results).to be_a Array
    expect(results.count).to eq(2)
    expect(results[0][:attributes][:name].downcase.include?("car")).to eq(true)
    expect(results[1][:attributes][:name].downcase.include?("car")).to eq(true)
  end

  it "can get list of items w/ partial search searching" do
    create(:item, name: "cat")
    create(:item, name: "Monster car")
    create(:item, name: "Truck car")
    create(:item, name: "Cartoon")

    get '/api/v1/items/find_all?name=ca'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items).to be_a(Hash)
    results = items[:data]
    expect(results).to be_a Array
    expect(results.count).to eq(4)
    expect(results[0][:attributes][:name].downcase.include?("ca")).to eq(true)
    expect(results[1][:attributes][:name].downcase.include?("ca")).to eq(true)
    expect(results[2][:attributes][:name].downcase.include?("ca")).to eq(true)
    expect(results[3][:attributes][:name].downcase.include?("ca")).to eq(true)
  end
end
