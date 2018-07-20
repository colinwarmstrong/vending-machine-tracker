require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  it 'they see the name of all of the snacks associated with that vending machine and their price' do
    owner = Owner.create(name: "Sam's Snacks")
    machine = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = machine.snacks.create(name: 'Chips', price: 3.50)
    snack_2 = machine.snacks.create(name: 'Candy', price: 1.50)

    visit machine_path(machine)

    expect(page).to have_content(snack_1.name)
    expect(page).to have_content(snack_1.price)
    expect(page).to have_content(snack_2.name)
    expect(page).to have_content(snack_2.price)
  end
end
