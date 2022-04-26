current_path = File.dirname(__FILE__)
require "#{current_path}/SalaryDecorator.rb"

class Post
  attr_accessor :title, :department, :vacant
  attr_writer :salary

  def salary
    @salary.get_salary
  end

  def initialize(title:, department:, salary:, percent:nil, rub:nil,
    premium:nil, fine:nil, vacant:)
    self.title = title
    self.department = department
    self.salary = Salary.get_instance(salary:salary, bonus_percent:percent,
    bonus_rub: rub, premium: premium, fine: fine)
    self.vacant = vacant
  end

  def to_s
    if @vacant == 1
      vacant = "Свободна"
    else
      vacant = "Занята"
    end
    "#{@title} #{@department} #{@salary.get_salary}₽ #{vacant}"
  end
end
