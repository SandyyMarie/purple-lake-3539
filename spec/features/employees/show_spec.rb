require 'rails_helper'

RSpec.describe 'When I visit the Employees#show page' do
  before :each do
    @dept_1 = Department.create!(name: "IT", floor: "Basement")
    @dept_2 = Department.create!(name: "HR", floor: "1st Floor")

    @employee_1 = @dept_1.employees.create!(name: "Sandy M", level: 3)
    @employee_2 = @dept_1.employees.create!(name: "Bryan L", level: 3)
    @employee_3 = @dept_2.employees.create!(name: "Miranda S", level: 4)

    @ticket_1 = @employee_1.tickets.create!(subject: "Forgot my password again", age: 1)
    @ticket_2 = @employee_1.tickets.create!(subject: "Would love a fourth monitor", age: 4)
    @ticket_3 = @employee_2.tickets.create!(subject: "Printer not working", age: 3)
  end

  it 'shows the given employees name and dept name, along with all the mployees tickets with ticket subject+age, ordered from oldest to youngest that are currently open (US#2)' do
    visit employees_path(@employee_1)

    expect(page).to have_content(@employee_1.name)
    expect(page).to have_content(@dept_1.name)
    expect(page).to have_content(@ticket_1.subject)
    expect(page).to have_content(@ticket_1.age)
    expect(page).to have_content(@ticket_2.subject)
    expect(page).to have_content(@ticket_2.age)

    expect(page).to_not have_content(@ticket_3.subject)
    expect(page).to_not have_content(@ticket_3.age)
  end
end

# Story 2
# Employee Show

# As a user,
# When I visit the Employee show page,
# I see the employee's name and department name,
# and I see a list of the employee's tickets including the ticket subject and age,
# And I see that this list is ordered from oldest to youngest, 
# And I see that this list only includes open tickets