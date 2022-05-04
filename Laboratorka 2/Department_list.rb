current_path = File.dirname(__FILE__)
require "yaml"
require "yaml/store"
require "#{current_path}/EntityOperations.rb"

class Department_list < EntityOperations
  attr_accessor :list

  def initialize(*array)
    # Список отделов
    @list = array
    @selectedEntity = nil
  end

  def Department_list.read_from_txt(fileName)
    file = File.new(fileName, "r")
    array = []
    for line in file.readlines
      object = line.split(',')
      dep = Department.new(object[0], object[1])
      object[2].split(',').select {|duty| dep.add_duty(duty)}
      array << dep
    end
    file.close()
    array
  end

  def Department_list.write_to_txt(fileName)
    File.open(fileName, "w") do |file|
      self.select {|dep| file.puts("#{dep.name}, #{dep.phone}, #{dep.get_duties},
        #{dep.post_list.get_posts}")}
    end
  end

  def Department_list.read_from_YAML(fileName)
    store = YAML::Store.new fileName
    departments = ""
    File.open(fileName, 'r') do |file|
      while (line = file.gets)
        departments += line
      end
    end
    store.load(departments)
  end

  def Department_list.write_to_YAML(fileName, list)
    File.new(fileName, 'w').puts YAML.dump(list)
  end

  def to_s
    output = ""
    @list.select{|dep| output += "#{dep.short_to_s}\n\n"}
    output
  end

  # Сортировка по названию
  def sort_notes
    @list.sort_by! {|department| department.name }
  end

  # Сортировка по количеству вакантных должностей
  def sort_vacant
    @list.sort_by! {|department| department.post_list.post_list.select {|post| post.vacant == 0}}
  end

  # Коллекция отделов по названию
  def departments_on_name(name)
    Department_list.new(@list.select {|dep| dep.name.downcase.include?(name)})
  end

  # Коллекция сотрудников, находящихся на данных должностях
  def employees_on_posts
    @list.select {|dep| dep.employees_on_posts}
  end

end
