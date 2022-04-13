current_path = File.dirname(__FILE__)
require "#{current_path}/EntityOperations.rb"

class Post_list < EntityOperations
  attr_accessor :list

  def initialize(array)
    # Список должностей
    @list = Array(array)
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

  def Post_list.write_to_txt(fileName, array)
    File.open(fileName, "w") do |file|
      array.select {|post| file.puts("#{post.title}, #{post.department},
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

  # Получить все вакантные должности отдела
  def get_vacant_posts
    @list.select {|post| post.vacant == 1}
  end

  def get_posts
    @list.select {|post| post}
  end
end
