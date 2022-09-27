require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  before :each do
    @dept_1 = Department.create!(name: "IT", floor: "Basement")

    @employee_1 = @dept_1.employees.create!(name: "Sandy M", level: 3)
    @employee_2 = @dept_1.employees.create!(name: "Bryan L", level: 3)

    @ticket_1 = @employee_1.tickets.create!(subject: "Forgot my password again", age: 1, open: true)
    @ticket_2 = @employee_1.tickets.create!(subject: "Would love a fourth monitor", age: 4, open: true)
    @ticket_3 = @employee_2.tickets.create!(subject: "Printer not working", age: 3, open: true)
    @ticket_4 = @employee_2.tickets.create!(subject: "Mouse Double Clicking", age: 5, open: false)
  end  

  it '#open_tickets' do
    expect(@employee_1.open_tickets).to eq([@ticket_1, @ticket_2])
    expect(@employee_2.open_tickets).to eq(@ticket_3)
  end
end