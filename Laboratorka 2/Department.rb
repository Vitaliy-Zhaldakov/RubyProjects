current_path = File.dirname(__FILE__)
require "#{current_path}/Post_list.rb"

class Department
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
    @selectedDuty = nil
    @duties = []
    @post_list = Post_list.new(posts)
  rescue
    nil
  end

  def to_s
    "Название: #{@name}\nТелефон: #{@phone}\nОбязанности: #{self.get_duties}"
  end

  # Урезанная форма
  def short_to_s
    "Название: #{@name}\nТелефон: #{@phone}\nКоличество обязанностей: #{@duties.length}
Число вакантных должностей: #{@post_list.get_vacant_posts.length}"
  end

  # Методы работы с обязанностями
  def add_duty(duty)
    @duties << duty
  end

  def select_duty(index)
    @selectedDuty = index
  end

  def delete_duty
    @duties.delete_at(@selectedDuty)
    @selectedDuty = nil
  end

  def get_text_selected_duty
    @duties[@selectedDuty]
  end

  def change_selected_duty(newDuty)
    @duties[@selectedDuty] = newDuty
  end

  def get_duties
    @duties.select {|duty| duty}
  end
end
