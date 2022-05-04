class Employee
  attr_accessor :passport, :address, :job_list
  attr_reader :phone, :email, :fio, :birthdate

  def phone=(value)
    raise ArgumentError if self.class.verify_phone(value) == false
    @phone = value
  end

  def email=(value)
    raise ArgumentError if self.class.verify_email(value) == false
    @email = value.downcase
  end

  def fio=(value)
    raise ArgumentError if self.class.verify_fio(value) == false
    @fio = value
  end

  def birthdate=(value)
    raise ArgumentError if self.class.verify_date(value) == false
    @birthdate = value
  end

  def Employee.verify_phone(phone)
    /7-[1-9]{3}-[1-9]{7}/.match(phone).to_s == phone
  end

  def Employee.verify_email(email)
    /\w+@[a-z]+\.[a-z]+/.match(email).to_s == email
  end

  def Employee.verify_fio(fio)
    /[а-яА-Я]+-?[а-яА-Я]* [а-яА-Я]+-?[а-яА-Я]* [а-яА-Я]+ ?[а-яА-Я]*/
    .match(fio).to_s == fio
  end

  def Employee.verify_date(birthdate)
    /0?[1-9]+\.[0-9]{2}\.[0-9]{2,4}/.match(birthdate).to_s == birthdate
  end

  def initialize(fio:, birthdate:, passport:,
  phone:, address:, email:)
    self.fio = fio
    self.birthdate = birthdate
    self.passport = passport
    self.phone = phone
    self.address = address
    self.email = email
    @job_list = nil
  rescue
    nil
  end

  def join_to_post(job)
    @job_list.add_entity(job)
  end

  # Равенство экземпляров по паспорту
  def ==(employee)
    self.passport == employee.passport
  end

end
