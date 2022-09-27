require 'rails_helper'

RSpec.describe 'When I visit the Departments#index page' do
  before :each do
    @dept_1 = Department.create!(name: "IT", floor: "Basement")
    @dept_2 = Department.create!(name: "HR", floor: "1st Floor")

    @employee_1 = @dept_1.employees.create!(name: "Sandy M", level: 3)
    @employee_2 = @dept_1.employees.create!(name: "Bryan L", level: 3)
    @employee_3 = @dept_2.employees.create!(name: "Miranda S", level: 4)

    @ticket_1 = @employee_1.tickets.create!(subject: "Forgot my password again", age: 1, open: true)
    @ticket_2 = @employee_1.tickets.create!(subject: "Would love a fourth monitor", age: 4, open: false)
    @ticket_3 = @employee_2.tickets.create!(subject: "Printer not working", age: 3, open: false)
    @ticket_4 = @employee_2.tickets.create!(subject: "Mouse Double Clicking", age: 5, open: false)
    @ticket_5 = @employee_3.tickets.create!(subject: "Keybrd buttns not wrkng", age: 2, open: false)
    @ticket_6 = @employee_3.tickets.create!(subject: "Monitor wont turn on cant see", age: 6, open: false)
    @ticket_7 = @employee_3.tickets.create!(subject: "Can't turn on computer now", age: 5, open: false)


  end

  it 'shows each departments name and floor, along with a list of each depts employees (US#1)' do
    visit departments_path 
    within("#dept-#{@dept_1.id}") do
      expect(page).to have_content(@dept_1.name)
      expect(page).to have_content(@dept_1.floor)
      expect(page).to have_content(@employee_1.name)
      expect(page).to have_content(@employee_2.name)
    end
    within("#dept-#{@dept_2.id}") do
      expect(page).to have_content(@dept_2.name)
      expect(page).to have_content(@dept_2.floor)
      expect(page).to have_content(@employee_3.name)
    end
  end
# Extension
# Top Employees

# As a user,
# When I visit the department index page,
# Then I see a section for "Top Employees",
# And in that section I see the names of the 3 employees
# who have the highest count of closed tickets, 
# and next to the employee name I see their count of closed tickets and their department
  xit 'shows a section for Top Employees that shows the names of the 3 employees with the highest count of closed tickets with the num of closed tickets next to their name' do #emp 3, 2, 1
    visit departments_path

    expect(@employee_3).to appear_before(@employee_2)
    expect(@employee_2).to appear_before(@employee_1)

    expect(page).to have_content("#{@employee_3.name} has 3 closed tickets")
    expect(page).to have_content("#{@employee_2.name} has 2 closed tickets")
    expect(page).to have_content("#{@employee_1.name} has 1 closed tickets")
  end
end