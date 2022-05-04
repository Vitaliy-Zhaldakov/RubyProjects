current_path = File.dirname(__FILE__)
require "#{current_path}/SalaryDecorator.rb"
require "#{current_path}/Job.rb"
require "#{current_path}/Employee_list.rb"


class Post
  attr_accessor :title, :department, :vacant, :job_list
  attr_writer :salary

  def salary
    @salary.get_salary
  end

  def initialize(title:, department:, salary:, percent:nil, rub:nil,
    premium:nil, fine:nil, vacant:, job_list:)
    self.title = title
    self.department = department
    self.salary = Salary.get_instance(salary:salary, bonus_percent:percent,
    bonus_rub: rub, premium: premium, fine: fine)
    self.vacant = vacant
    @job_list = job_list
  end

  def to_s
    if @vacant == 1
      vacant = "Свободна"
    else
      vacant = "Занята"
    end
    "#{@title} #{@department} #{@salary.get_salary}₽ #{vacant}"
  end

  # Принять на должность
  def accept_on_post(employee, bid)
    time = Time.new
    hiredate = "#{time.day}.#{time.month}.#{time.year}"
    job = Job.new(self.title, employee, hiredate, bid)
    employee.join_to_post(job)
  end

  # Уволить с должности
  def fire_from_post(job)
    @job_list.delete(job)
  end

  # Коллекция сотрудников, находящихся на данной должности
  def employees_of_post
    jobs = Job_list.new(@job_list.select {|job| job.post == @title and
      job.firedate != nil})
    Employee_list.new(jobs.select {|job| job.employee})
  end
end
