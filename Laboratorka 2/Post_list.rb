class Post_list
  attr_accessor :post_list

  def initialize(array)
    @post_list = Array(array)
    @selectedPost = nil
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

  # Методы работы с должностями
  def add_post(post)
    @post_list << post
  end

  def select_post(index)
    @selectedPost = index
  end

  def delete_post
    @post_list.delete_at(@selectedPost)
    @selectedPost = nil
  end

  def change_post(newPost)
    @post_list[@selectedPost] = newPost
  end

  # Получить все вакантные должности отдела
  def get_vacant_posts
    @post_list.select {|post| post.vacant == 1}
  end

  def get_posts
    @post_list.select {|post| post}
  end
end
