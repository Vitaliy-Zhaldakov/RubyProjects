require "yaml"
require "yaml/store"

class Department
  attr_accessor :name, :selectedDuty
  attr_reader :phone

  def phone=(value)
    raise Runtime Error if self.class.verify_phone(value) == false
    @phone = value
  end

  def self.verify_phone(phone)
    /[1-9]+-[1-9]+-[1-9]+/.match(phone).to_s == phone
  end

  def initialize(name, phone)
    self.phone = phone
    self.name = name
    @duties = []
  rescue
    nil
  end

  def to_s
    "#{@name} #{@phone}"
  end

  def add_duty(duty)
    @duties << duty
  end

  def select_duty(index)
    @selectedDuty = index
  end

  def delete_duty
    @duties.delete_at(@selectedDuty)
    @selectedDuty = nil
  end

  def get_text_selected_duty
    @duties[@selectedDuty]
  end

  def change_selected_duty(newDuty)
    @duties[@selectedDuty] = newDuty
  end

  def get_duties
    @duties.to_s
  end

end

def write_to_txt(fileName, object)
  hash = {name: object.name, phone: object.phone}
  File.open(fileName, "a").puts hash
end

def read_from_txt(fileName)
  File.open(fileName, "r").readlines.map { |line| eval(line.chomp) }
end

def write_to_YAML(fileName, object)
  File.open(fileName, 'a') do |file|
    file.puts YAML.dump(object)
  end
end

def read_from_YAML(fileName)
  store = YAML::Store.new fileName
  departments = ""
  File.open(fileName, 'r') do |file|
    while (line = file.gets)
      departments += line
    end
  end
  store.load(departments)
end

hr = Department.new("Отдел кадров", "261-55-11")
logistics = Department.new("Отдел логистики", "261-46-89")
finance = Department.new("Отдел финансов", "261-99-66")

write_to_YAML("departments.yml", finance)
read_from_YAML("departments.yml")

hr.add_duty("Проверить адрес работника")
hr.add_duty("Добавить работника")
hr.add_duty("Изменить номер работника")
puts hr.get_duties

hr.select_duty(2)
hr.delete_duty
puts hr.get_duties

hr.change_selected_duty("Проверить сертификат работника")
puts hr.get_duties
