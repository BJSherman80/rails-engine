require 'rails_helper'

describe "Item API" do

  it "sends a list of items" do

    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    json = JSON.parse(response.body,  symbolize_names: true)
    items = json[:data]

    items.each do |item|

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      item_data = item[:attributes]

      expect(item_data).to have_key(:name)
      expect(item_data[:name]).to be_a(String)
      expect(item_data).to have_key(:description)
      expect(item_data[:name]).to be_a(String)
      expect(item_data).to have_key(:unit_price)
      expect(item_data[:name]).to be_a(String)
      expect(item_data).to have_key(:merchant_id)
      expect(item_data[:name]).to be_a(String)
    end
  end

  it "can get one customer by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data]
    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to eq("item")

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    item_data = item[:attributes]

    expect(item_data).to have_key(:name)
    expect(item_data[:name]).to be_a(String)
    expect(item_data).to have_key(:description)
    expect(item_data[:name]).to be_a(String)
    expect(item_data).to have_key(:unit_price)
    expect(item_data[:name]).to be_a(String)
    expect(item_data).to have_key(:merchant_id)
    expect(item_data[:name]).to be_a(String)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id
    item_params = { name: 'Bike', description: "Fast and red", unit_price: "50.00", merchant_id: "#{merchant_id}" }

    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last
    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price].to_f)
    expect(created_item.merchant_id).to eq(item_params[:merchant_id].to_f)
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: 'Bike', description: "Fast and red", unit_price: "50.00" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price].to_f)

  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can return merchant that has that item' do
    create(:item)
    get "/api/v1/items/#{Item.last.id}/merchants"
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]
    expect(merchant).to be_an(Hash)
    expect(merchant[:id]).to eq(Merchant.last.id.to_s)
  end


end
