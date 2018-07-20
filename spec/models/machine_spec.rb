require 'rails_helper'

describe Machine, type: :model do
  describe 'validations' do
    it {should belong_to :owner}
    it {should have_many :machine_snacks}
    it {should have_many :snacks}
  end

  describe 'Instance Methods' do
    it '#average_snack_price' do
      owner = Owner.create(name: "Sam's Snacks")
      machine = owner.machines.create(location: "Don's Mixed Drinks", owner_id: owner.id )
      machine.snacks.create(name: 'Mentos', price: 1.00)
      machine.snacks.create(name: 'Twizzlers', price: 2.00)
      machine.snacks.create(name: 'Chips', price: 3.00)

      expect(machine.average_snack_price).to eq(2.00)
    end

    it '#snack_count' do
      owner = Owner.create(name: "Sam's Snacks")
      machine = owner.machines.create(location: "Don's Mixed Drinks", owner_id: owner.id )
      machine.snacks.create(name: 'Mentos', price: 1.95)
      machine.snacks.create(name: 'Twizzlers', price: 1.35)
      machine.snacks.create(name: 'Chips', price: 1.55)

      expect(machine.snack_count).to eq(3)
    end
  end
end
