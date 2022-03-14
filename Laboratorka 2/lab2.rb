class Department
  attr_accessor :name, :phone, :duties, :highlightedDuty

  def self.verify_phone(phone)
    /[1-9]+-[1-9]+-[1-9]+/.match(phone).to_s == phone
  end

  def initialize(name, phone)
    raise "Error phone number" if self.class.verify_phone(phone) == false
    @name = name
    @phone = phone
    @duties = []
  rescue
  end

  def get_info
    puts "#{@name} -> телефон: #{@phone}"
  end

  def add_duty(duty)
    @duties << duty
  end

  def delete_duty(selectedDuty)
    @duties.delete(selectedDuty)
  end

  def highlight_duty(selectedDuty)
    @highlightedDuty = @duties[@duties.index(selectedDuty)]
  end

  def get_text_highlighted_duty
    puts @highlightedDuty
  end

  def change_highlighted_duty(newDuty)
    @duties[@duties.index(@highlightedDuty)] = newDuty
  end

  def get_duties
    puts "----- Список обязанностей -----"
    puts @duties
  end

end

def write_to_txt(fileName, array)
  File.open(fileName, "a").puts array
end

def read_from_txt(fileName)
  File.open(fileName, "r").readlines.map { |line| eval(line.chomp) }
end

hr = Department.new("Отдел кадров", "261-55-11")
logistics = Department.new("Отдел логистики", "261-46-89")
finance = Department.new("Отдел финансов", "261-99-66")

puts "----- Информация об отделах -----"
hr.get_info
logistics.get_info
finance.get_info

hr.add_duty("Проверить адрес работника")
hr.add_duty("Добавить работника")
hr.add_duty("Изменить номер работника")
hr.get_duties

hr.delete_duty("Добавить работника")
hr.get_duties

hr.highlight_duty("Проверить адрес работника")
hr.change_highlighted_duty("Проверить сертификат работника")
hr.get_duties
