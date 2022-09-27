class EmployeeTicketsController < ApplicationController
  def create
    employee = Employee.find(params[:employee_id])
    ticket = Ticket.find(params[:ticket_id])
    EmployeeTicket.create(ticket: ticket, employee: employee)
    redirect_to employee_path(employee)
  end
end