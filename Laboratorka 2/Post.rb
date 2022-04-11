class Post
  attr_accessor :title, :department, :salary, :vacant

  def initialize(title, department, salary, vacant)
    @title = title
    @department = department
    @salary = salary
    @vacant = vacant
  end

  def to_s
    if vacant == 1
      vacant = "Свободна"
    else
      vacant = "Занята"
    end
    "#{@title} #{@department} #{@salary}₽ #{vacant}"
  end
end
