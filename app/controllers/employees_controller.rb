class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
  end

  def create
    employee = Employee.find(params[:id])
    ticket = Ticket.new(emp_params, age: 1)

    if ticket.save
      redirect_to employee_path(employee)
    else
      flash[:alert] = "Form was NOT saved, try again"
      redirect_to employee_path(employee)
    end
  end

  private
  def emp_params
    params.permit(:subject)
  end
end