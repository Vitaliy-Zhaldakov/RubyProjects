class Department
  attr_accessor :name, :phone

  def initialize(name, phone)
    @name = name
    @phone = phone
  end

  def getInfo
    puts "#{@name} -> телефон: #{@phone}"
  end
end

hr = Department.new("Отдел кадров", "261-55-11")
logistics = Department.new("Отдел логистики", "261-46-89")
finance = Department.new("Отдел финансов", "261-99-66")

puts "----- Информация об отделах -----"
hr.getInfo
logistics.getInfo
finance.getInfo
