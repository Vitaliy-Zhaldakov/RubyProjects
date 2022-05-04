current_path = File.dirname(__FILE__)
require "yaml"
require "yaml/store"
require "#{current_path}/EntityOperations.rb"
require "#{current_path}/Employee.rb"

class Employee_list < EntityOperations
  # Поле, содержащее объект
  @@instance=nil
  attr_accessor :list

  # Метод, создающий одиночку
  def Employee_list.get_instance(*array)
    if @@instance
      @@instance.set_parameters(array)
    else
      @@instance = Employee_list.new(array)
    end
    @@instance
  end

  # "Ленивая инициализация"
  def set_parameters(array)
    # Список работников
    @list = array
    @selectedEntity = nil
  end

  # Приватный конструктор
  private def initialize(array)
    self.set_parameters(array)
  end

  def Employee_list.read_from_txt(fileName)
    file = File.new(fileName, "r")
    array = []
    for line in file.readlines
      object = line.split(',')
      emp = Employee.new(surname:object[0], name:object[1], lastname:object[2], birthdate:object[3],
      passport:object[4], phone:object[5], address:object[6], email:object[7])
      array << emp
    end
    file.close()
    array
  end

  def Employee_list.write_to_txt(fileName)
    File.open(fileName, "w") do |file|
      self.select {|emp| file.puts("#{emp.surname}, #{emp.name}, #{emp.lastname},
        #{emp.birthdate}, #{emp.passport}, #{emp.phone}, #{emp.address}, #{emp.email}")}
    end
  end

  def Employee_list.read_from_YAML(fileName)
    store = YAML::Store.new fileName
    employees = ""
    File.open(fileName, 'r') do |file|
      while (line = file.gets)
        employees += line
      end
    end
    store.load(employees)
  end

  def Employee_list.write_to_YAML(fileName, list)
    File.new(fileName, 'w').puts YAML.dump(list)
  end

 # Коллекция работников по ФИО
  def employees_on_FIO(fio)
    Employee_list.new(@list.select {|emp| emp.surname.downcase.include?(fio) or
      emp.name.downcase.include?(fio) or emp.lastname.downcase.include?(fio)})
  end

  # Вычисление полного возраста
  def current_age(birth, curDate)
    age = curDate.year - birth.year
    age = age - 1 if (
      birth.month > curDate.month or
      (birth.month >= curDate.month and birth.day > curDate.day)
      )
    age
  end

  # Сотрудники выбранного возраста
  def employees_on_age(age)
    curDate = Time.new
    Employee_list.new(@list.select {|emp|
      current_age(Time.new(emp.birthdate.split(".")[2], emp.birthdate.split(".")[1],
      emp.birthdate.split(".")[0]), curDate) == age})
  end
end
