current_path = File.dirname(__FILE__)
require "#{current_path}/EntityOperations.rb"

class Post_list < EntityOperations
  attr_accessor :list

  def initialize(*array)
    # Список должностей
    @list = array
    @selectedEntity = nil
  end

  def Post_list.read_from_txt(fileName)
    file = File.new(fileName, "r")
    array = []
    for line in file.readlines
      object = line.split(',')
      post = Post.new(object[0], object[1], object[2], object[3])
      array << post
    end
    file.close()
    array
  end

  def Post_list.write_to_txt(fileName)
    File.open(fileName, "w") do |file|
      @list.select {|post| file.puts("#{post.title}, #{post.department},
        #{post.salary}, #{post.vacant}")}
    end
  end

  def Post_list.read_from_YAML(fileName)
    store = YAML::Store.new fileName
    posts = ""
    File.open(fileName, 'r') do |file|
      while (line = file.gets)
        posts += line
      end
    end
    store.load(posts)
  end

  def Post_list.write_to_YAML(fileName, object)
    File.open(fileName, 'a').puts YAML.dump(object)
  end

  # Коллекция должностей, относящихся к заданному отделу
  def posts_of_department(department)
    Post_list.new(@list.select {|post| post.department == department})
  end

  # Коллекция вакантных должностей, относящихся к заданному отделу
  def vacant_posts_of_dep(department)
    Post_list.new(@list.select {|post| post.department == department and
      post.vacant == 1})
  end

  # Коллекция должностей по названию
  def posts_on_title(title)
    Post_list.new(@list.select {|post| post.title.downcase.include?(title)})
  end

  # Получить все вакантные должности отдела
  def get_vacant_posts
    @list.select {|post| post.vacant == 1}
  end

  def get_posts
    @list.select {|post| post}
  end

  # Коллекция всех сотрудников, находящихся на данных должностях
  def employees_on_posts
    jobs = @list.select {|post| post.job_list}
    Employee_list.new(jobs.select {|job| job.employee})
  end
  
end
