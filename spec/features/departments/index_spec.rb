require 'rails_helper'

RSpec.describe 'When I visit the Departments#index page' do
  before :each do
    @dept_1 = Department.create!(name: "IT", floor: "Basement")
    @dept_2 = Department.create!(name: "HR", floor: "1st Floor")

    @employee_1 = @dept_1.employees.create!(name: "Sandy M", integer: 3)
    @employee_2 = @dept_1.employees.create!(name: "Bryan L", integer: 3)
    @employee_3 = @dept_2.employees.create!(name: "Miranda S", integer: 4)

  end

  # Story 1
# Department Index

# As a user,
# When I visit the Department index page,
# I see each department's name and floor
# And underneath each department, I can see the names of all of its employees

  it 'shows each departments name and floor, along with a list of each depts employees (US#1)' do
    visit department_path #update once routes are made
    expect(page).to have_content(@dept_1.name)
    expect(page).to have_content(@dept_1.floor)

    expect(page).to have_content(@dept_2.name)
    expect(page).to have_content(@dept_2.floor)

    expect(page).to have_content(@employee_1.name)
    expect(page).to have_content(@employee_2.name)
    expect(page).to have_content(@employee_3.name)
  end
end