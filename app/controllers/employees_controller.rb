class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
  end




  # private
  # def emp_params
  #   params.permit(:subject)
  # end
end