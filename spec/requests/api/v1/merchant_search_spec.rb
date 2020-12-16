
require 'rails_helper'

RSpec.describe "Merchant API search" do
  it "can get list of merchants when searching" do
    create(:merchant, name: "Burts Buttons")
    create(:merchant, name: "Billys Bakery")
    create(:merchant, name: "Zades-beads")
    create(:merchant, name: "ZZZ's Kittens")

    get '/api/v1/merchants/find_all?name=b'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants).to be_a(Hash)
    results = merchants[:data]
    expect(results).to be_a Array
    expect(results.count).to eq(3)
    expect(results[0][:attributes][:name].downcase.include?("b")).to eq(true)
    expect(results[1][:attributes][:name].downcase.include?("b")).to eq(true)
    expect(results[2][:attributes][:name].downcase.include?("b")).to eq(true)
  end

  it "can get a merchant when searching" do
    create(:merchant, name: "Burts")
    create(:merchant, name: "Burt")

    get '/api/v1/merchants/find?name=Burts'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants).to be_a(Hash)
    results = merchants[:data]
    expect(results).to be_a Hash
    expect(results[:attributes][:name].include?("Burts")).to eq(true)
    # expect(results[:attributes][:name]).to_not include("Burt")
  end
end
