current_path = File.dirname(__FILE__)
require "#{current_path}/Employee.rb"

class Skilled_employee < Employee
  attr_accessor :work_experience, :work_description

  def initialize(surname:, name:, lastname:, birthdate:, passport:,
  phone:, address:, email:, work_experience:, work_description:)
  super(surname:surname, name:name, lastname:lastname, birthdate:birthdate,
    passport:passport, phone:phone, address:address, email:email)

  self.work_experience = work_experience
  self.work_description = work_description
end
