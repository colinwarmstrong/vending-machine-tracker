require 'rails_helper'


describe "User visits 'snacks/:id'" do
  it 'they can see the name and price of the snack' do
    snack = Snack.create(name: 'Snickers', price: 1.50)

    visit snack_path(snack)

    expect(page).to have_content(snack.name)
    expect(page).to have_content("Price: $#{snack.price}")
  end

  it 'they can see a list of locations with vending machines that carry that snack' do
    snack = Snack.create(name: 'Snickers', price: 1.50)
    owner = Owner.create(name: "Sam's Snacks")
    machine_1 = snack.machines.create(location: "Don's Mixed Drinks", owner_id: owner.id )
    machine_2 = snack.machines.create(location: "Turing Basement", owner_id: owner.id)

    visit snack_path(snack)

    within '#locations' do
      expect(page).to have_content(machine_1.location)
      expect(page).to have_content(machine_2.location)
    end
  end

  it 'they see the average price of snack in each vending machine' do
    snack = Snack.create(name: 'Snickers', price: 1.50)
    owner = Owner.create(name: "Sam's Snacks")
    machine_1 = snack.machines.create(location: "Don's Mixed Drinks", owner_id: owner.id )
    machine_2 = snack.machines.create(location: "Turing Basement", owner_id: owner.id)

    visit snack_path(snack)

    within '#locations' do
      expect(page).to have_content("Average Price for Vending Machine: $#{machine_1.average_snack_price}")
      expect(page).to have_content("Average Price for Vending Machine: $#{machine_2.average_snack_price}")
    end
  end

  it 'they see a count of the different kinds of snacks in that vending machine' do
    snack = Snack.create(name: 'Snickers', price: 1.50)
    owner = Owner.create(name: "Sam's Snacks")
    machine_1 = snack.machines.create(location: "Don's Mixed Drinks", owner_id: owner.id )
    machine_2 = snack.machines.create(location: "Turing Basement", owner_id: owner.id)

    visit snack_path(snack)

    within '#locations' do
      expect(page).to have_content("Average Price for Vending Machine: $#{machine_1.average_snack_price}")
      expect(page).to have_content("Average Price for Vending Machine: $#{machine_2.average_snack_price}")
    end
  end
end
