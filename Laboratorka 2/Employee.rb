class Employee
  attr_accessor :surname, :name, :lastname, :birthdate, :passport,
  :phone, :address, :email

  def initialize(surname:, name:, lastname:, birthdate:, passport:,
  phone:, address:, email:)
    self.surname = surname
    self.name = name
    self.lastname = lastname
    self.birthdate = birthdate
    self.passport = passport
    self.phone = phone
    self.address = address
    self.email = email
  end
end
