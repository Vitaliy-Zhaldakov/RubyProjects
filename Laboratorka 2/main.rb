current_path = File.dirname(__FILE__)
require "#{current_path}/Department.rb"
require "#{current_path}/Department_list.rb"
require "#{current_path}/Post.rb"
require "#{current_path}/Post_list.rb"

def main
  salesConsultant = Post.new("Продавец-консультант", "Отдел обслуживания", 35000, 1)
  logisticsManager = Post.new("Управляющий", "Отдел логистики", 45000, 0)

  hr = Department.new("Отдел кадров", "261-55-11", [salesConsultant, logisticsManager])
  logistics = Department.new("Отдел логистики", "261-46-89", salesConsultant)
  finance = Department.new("Отдел финансов", "261-99-66")

  hr.add_duty("Проверить адрес работника")
  hr.add_duty("Добавить работника")
  finance.add_duty("Изменить номер работника")

  # logistics.add_post(salesСonsultant)
  # logistics.add_post(logisticsManager)
  # puts logistics.get_posts

  # hr.change_selected_duty("Проверить сертификат работника")
end

if __FILE__ == $0
  main
end
