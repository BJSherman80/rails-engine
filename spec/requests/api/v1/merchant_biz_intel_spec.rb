require 'rails_helper'

RSpec.describe 'Merchant_intelligence' do
  before :each do
    #create 5 merchants
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    #create 1 item for each merchant
    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    @item3 = create(:item, merchant: @merchant3)
    @item4 = create(:item, merchant: @merchant4)
    @item5 = create(:item, merchant: @merchant5)
    #create one invoice for each merchant
    @invoice1 = create(:invoice, merchant: @merchant1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    @invoice2 = create(:invoice, merchant: @merchant2, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    @invoice3 = create(:invoice, merchant: @merchant3, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    @invoice4 = create(:invoice, merchant: @merchant4, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    @invoice5 = create(:invoice, merchant: @merchant5, status: 'packaged', created_at: '2020-01-01T00:00:00 UTC')
    #one invoice_item for each incvoice
    @ii1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1, unit_price: 1.0) #revenue = $1
    @ii2 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 2, unit_price: 2.0) #revenue = $4
    @ii3 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 3, unit_price: 3.0) #revenue = $9
    @ii4 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 4, unit_price: 4.0) #revenue = $16
    @ii5 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 5, unit_price: 5.0) #revenue = $25
    #one transaction for each invoice
    @transaction1 = create(:transaction, invoice: @invoice1, result: 'success')
    @transaction2 = create(:transaction, invoice: @invoice2, result: 'success')
    @transaction3 = create(:transaction, invoice: @invoice3, result: 'success')
    @transaction4 = create(:transaction, invoice: @invoice4, result: 'success')
    @transaction5 = create(:transaction, invoice: @invoice5, result: 'success')
  end
  it 'can get quantity of merchants w/ most revenue' do
     get "/api/v1/merchants/most_revenue?quantity=4"#number of items is 4
     json = JSON.parse(response.body, symbolize_names: true )
     results = json[:data]
     expect(results).to be_an(Array)
     expect(results.length).to eq(4)
     expect(results[0]).to have_key(:id)
     expect(results[0][:id]).to eq(@merchant4.id.to_s)
     expect(results[0]).to have_key(:attributes)
     expect(results[0][:attributes]).to have_key(:name)
     expect(results[0][:attributes][:name]).to eq(@merchant4.name)
  end
  it 'can get quantity of merchants w/ most items sold' do
     get "/api/v1/merchants/most_items?quantity=2"#number of items is 2
     json = JSON.parse(response.body, symbolize_names: true )
     results = json[:data]
     expect(results).to be_an(Array)
     expect(results.length).to eq(2)
     expect(results[0]).to have_key(:id)
     expect(results[0][:id]).to eq(@merchant4.id.to_s)
     expect(results[0]).to have_key(:attributes)
     expect(results[0][:attributes]).to have_key(:name)
     expect(results[0][:attributes][:name]).to eq(@merchant4.name)
  end
  it 'can get revenue for a merchant' do
     get "/api/v1/merchants/#{@merchant2.id}/revenue"
     json = JSON.parse(response.body, symbolize_names: true )
     results = json[:data]
     # binding.pry
     expect(results).to be_an(Hash)
     expect(results).to have_key(:id)
     expect(results[:id]).to eq(nil)
     expect(results).to have_key(:attributes)
     expect(results[:attributes]).to have_key(:revenue)
     expect(results[:attributes][:revenue]).to eq(@ii2.quantity * @ii2.unit_price)
  end
end
