class Department
  attr_accessor :name, :phone, :duties, :highlightedDuty

  def self.verifyPhone(phone)
    /[1-9]+-[1-9]+-[1-9]+/.match(phone).to_s == phone
  end

  def initialize(name, phone)
    raise "Error phone number" if self.class.verifyPhone(phone) == false
    @name = name
    @phone = phone
    @duties = []
  rescue
  end

  def getInfo
    puts "#{@name} -> телефон: #{@phone}"
  end

  def addDuty(duty)
    @duties << duty
  end

  def deleteDuty(selectedDuty)
    @duties.delete(selectedDuty)
  end

  def highlightDuty(selectedDuty)
    @highlightedDuty = @duties[@duties.index(selectedDuty)]
  end

  def getTextHighlightedDuty
    puts @highlightedDuty
  end

  def changeHighlightedDuty(newDuty)
    @duties[@duties.index(@highlightedDuty)] = newDuty
  end

  def getDuties
    puts "----- Список обязанностей -----"
    puts @duties
  end

end

hr = Department.new("Отдел кадров", "261-55-11")
logistics = Department.new("Отдел логистики", "261-46-89")
finance = Department.new("Отдел финансов", "261-99-66")

puts "----- Информация об отделах -----"
hr.getInfo
logistics.getInfo
finance.getInfo

hr.addDuty("Проверить адрес работника")
hr.addDuty("Добавить работника")
hr.addDuty("Изменить номер работника")
hr.getDuties

hr.deleteDuty("Добавить работника")
hr.getDuties

hr.highlightDuty("Проверить адрес работника")
hr.changeHighlightedDuty("Проверить сертификат работника")
hr.getDuties
