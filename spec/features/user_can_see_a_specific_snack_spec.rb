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

    machine_1.snacks.create(name: 'Crunch', price: 1.25)
    machine_1.snacks.create(name: 'Gum', price: 1.05)

    machine_2.snacks.create(name: 'Mentos', price: 1.95)
    machine_2.snacks.create(name: 'Twizzlers', price: 1.35)
    machine_2.snacks.create(name: 'Chips', price: 1.55)

    visit snack_path(snack)

    within '#locations' do
      expect(page).to have_content("Snack Count for #{machine_1.location}: 3")
      expect(page).to have_content("Snack Count for #{machine_2.location}: 4")
    end
  end
end
