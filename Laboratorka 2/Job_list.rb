current_path = File.dirname(__FILE__)
require "yaml"
require "yaml/store"
require "#{current_path}/EntityOperations.rb"
require "#{current_path}/Job.rb"
require "#{current_path}/Employee_list.rb"

class Job_list < EntityOperations
  attr_accessor :list

  def initialize(*array)
    # Список должностей сотрудников
    @list = array
    @selectedEntity = nil
  end

  def Job_list.read_from_txt(fileName)
    file = File.new(fileName, "r")
    array = []
    for line in file.readlines
      object = line.split(',')
      job = Job.new(object[0], object[1], object[2], object[3], object[4])
      array << job
    end
    file.close()
    array
  end

  def Job_list.write_to_txt(fileName)
    File.open(fileName, "w") do |file|
      self.select {|job| file.puts("#{job.post}, #{job.employee}, #{job.hiredate},
        #{job.firedate}, #{job.percent_bid}")}
    end
  end

  def Job_list.read_from_YAML(fileName)
    store = YAML::Store.new fileName
    jobs = ""
    File.open(fileName, 'r') do |file|
      while (line = file.gets)
        jobs += line
      end
    end
    store.load(jobs)
  end

  def Job_list.write_to_YAML(fileName, list)
    File.new(fileName, 'w').puts YAML.dump(list)
  end

  # Коллекция по заданной должности
  def jobs_of_post(post)
    Job_list.new(@list.select {|job| job.post == post})
  end

  # Коллекция по заданному сотруднику
  def jobs_of_employee(employee)
    Job_list.new(@list.select {|job| job.employee == employee})
  end

  # Коллекция текущих должностей по сотруднику
  def current_jobs_employee(employee)
    Job_list.new(@list.select {|job| job.employee == employee and
      job.firedate != nil})
  end

  # Список всех сотрудников
  def current_employees
    Employee_list.new(@list.select {|job| job.employee})
  end

end
