require 'rails_helper'

RSpec.describe "As a visitor when I visit '/supermarkets/:id" do
  before :each do
    @king_soops = Supermarket.create!(name: "King Soopers", location: "123 Food St.")
    @city_market = Supermarket.create!(name: "City Market", location: "456 Food St.")
    @bagel = @king_soops.items.create!(name: "Everything Bagel", price: 2)
    @egg = @king_soops.items.create!(name: "Egg (not microwaved)", price: 1)
    @bacon = @king_soops.items.create!(name: "Thick-Cut Bacon", price: 4)
    @cheese = @king_soops.items.create!(name: "Estate Gouda", price: 3)
    @hot_sauce = @city_market.items.create!(name: "Swamp Mustard", price: 6)

    @reed = @bagel.customers.create!(name: "Reed")
    @bob = @bagel.customers.create!(name: "Bob")
    @mike = @bagel.customers.create!(name: "Mike")

    @reed.items << @egg
    @reed.items << @bacon
    @reed.items << @cheese
    @bob.items << @hot_sauce
    @bob.items << @cheese
    @mike.items << @egg
    @mike.items << @hot_sauce
  end

  it "I see a unique list of all customers that have shopped at the supermarket" do
    visit "/supermarkets/#{@city_market.id}"

    expect(page).to have_content(@bob.name)
    expect(page).to have_content(@mike.name)
    expect(page).not_to have_content(@reed.name)

    visit "/supermarkets/#{@king_soops.id}"


    expect(page).to have_content(@bob.name)
    expect(page).to have_content(@mike.name)
    expect(page).to have_content(@reed.name)
  end
end