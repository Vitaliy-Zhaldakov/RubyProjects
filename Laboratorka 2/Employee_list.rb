current_path = File.dirname(__FILE__)
require "yaml"
require "yaml/store"
require "#{current_path}/EntityOperations.rb"

class Employee_list < EntityOperations
  attr_accessor :list

  def initialize(*array)
    # Список работников
    @list = array
    @selectedEntity = nil
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
