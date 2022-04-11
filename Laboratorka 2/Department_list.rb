require "yaml"
require "yaml/store"

class Department_list
  attr_accessor :arrayDepartments

  def initialize(array)
    @arrayDepartments = Array(array)
    @selectedNote = nil
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
    @arrayDepartments.select{|dep| output += "#{dep.short_to_s}\n\n"}
    output
  end

  def add_note(note)
    @arrayDepartments << note
  end

  def choose_note(index)
    @selectedNote = index
  end

  def change_note(newNote)
    @arrayDepartments[@selectedNote] = newNote
  end

  def get_selected_note
    @arrayDepartments[@selectedNote]
  end

  def delete_note
    @arrayDepartments.delete_at(@selectedNote)
    @selectedNote = nil
  end

  def sort_notes
    @arrayDepartments.sort_by! {|department| department.name }
  end
end
