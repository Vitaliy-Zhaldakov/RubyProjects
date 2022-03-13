class Department
  attr_accessor :name, :phone, :duties, :highlightedDuty

  def initialize(name, phone)
    @name = name
    @phone = phone
    @duties = []
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
