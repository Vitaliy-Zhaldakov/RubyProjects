current_path = File.dirname(__FILE__)
require "#{current_path}/Post_list.rb"
require "#{current_path}/EntityOperations.rb"

class Department < EntityOperations
  attr_accessor :name, :post_list
  attr_reader :phone

  def phone=(value)
    raise ArgumentError if self.class.verify_phone(value) == false
    @phone = value
  end

  def self.verify_phone(phone)
    /[1-9]+-[1-9]+-[1-9]+/.match(phone).to_s == phone
  end

  def initialize(name, phone, posts=[])
    self.phone = phone
    self.name = name
    @post_list = Post_list.new(posts)
    # Обязанности
    @selectedEntity = nil
    @list = []
  rescue
    nil
  end

  def to_s
    "Название: #{@name}\nТелефон: #{@phone}\nОбязанности: #{self.get_duties}"
  end

  # Урезанная форма
  def short_to_s
    "Название: #{@name}\nТелефон: #{@phone}\nКоличество обязанностей: #{@list.length}
Число вакантных должностей: #{@post_list.get_vacant_posts.length}"
  end

  def get_duties
    @list.select {|duty| duty}
  end
end
