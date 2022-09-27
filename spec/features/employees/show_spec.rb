require 'rails_helper'

RSpec.describe 'When I visit the Employees#show page' do
  before :each do
    @dept_1 = Department.create!(name: "IT", floor: "Basement")
    @dept_2 = Department.create!(name: "HR", floor: "1st Floor")

    @employee_1 = @dept_1.employees.create!(name: "Sandy M", level: 3)
    @employee_2 = @dept_1.employees.create!(name: "Bryan L", level: 3)
    @employee_3 = @dept_2.employees.create!(name: "Miranda S", level: 4)

    @ticket_1 = @employee_1.tickets.create!(subject: "Forgot my password again", age: 1, open: true)
    @ticket_2 = @employee_1.tickets.create!(subject: "Would love a fourth monitor", age: 4, open: true)
    @ticket_3 = @employee_2.tickets.create!(subject: "Printer not working", age: 3, open: true)
    @ticket_4 = @employee_2.tickets.create!(subject: "Mouse Double Clicking", age: 5, open: false)

  end

  it 'shows the given employees name and dept name, along with all the employees tickets with ticket subject+age, ordered from oldest to youngest(US#2)' do

    visit employee_path(@employee_1)

    expect(page).to have_content(@employee_1.name)
    expect(page).to have_content(@dept_1.name)
    expect(page).to have_content(@ticket_1.subject)
    expect(page).to have_content(@ticket_1.age)
    expect(page).to have_content(@ticket_2.subject)
    expect(page).to have_content(@ticket_2.age)

    expect(@ticket_2.subject).to appear_before(@ticket_1.subject)

    expect(page).to_not have_content(@ticket_3.subject)
    expect(page).to_not have_content(@ticket_3.age)
  end

  it 'Only shows invoices that are currently open (US#2)' do
    visit employee_path(@employee_2)
    expect(page).to have_content(@ticket_3.subject)
    expect(page).to have_content(@ticket_3.age)

    expect(page).to_not have_content(@ticket_4.subject)
    expect(page).to_not have_content(@ticket_4.age)
  end

#   Story 3
# Assign an Open Ticket to an Employee

# As a user,
# When I visit the employee show page,
# I do not see any open tickets listed that are not assigned to the employee

# and I see a form to add a ticket to this employee
# When I fill in the form with the id of an open ticket that already exists in the database
# and I click submit

# Then I am redirected back to that employee's show page
# and I see the ticket's subject now listed
# (you do not have to test for sad path, for example if the id does not match an existing ticket)

  it 'if i do not see any open tickets i instead see a form to add a ticket to this employee, when form is filled out and submitted you return to #show page to see listed ticket (US#3)' do
    visit employee_path(@employee_3)
    expect(page).to_not have_content(@ticket_1.subject)
    fill_in "Ticket ID:", with: @ticket_1.id
    click_button('Submit')
    expect(current_path).to eq(employee_path(@employee_3))
    expect(page).to have_content(@ticket_1.subject)
  end
end
