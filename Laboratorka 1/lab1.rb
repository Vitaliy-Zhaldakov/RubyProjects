# Block 1 Task 1
puts "Hello World"

# Block 1 Task 2
# ARGV - аргумент программы
puts "Hello, #{ARGV[0]}"

# Block 1 Task 3
ARGV.clear
puts "Какой ваш любимый язык?"
language = gets

# Variant 1
if language.chomp == "Ruby"
  puts "Подлиза" 
else 
  puts "Скоро будет Ruby" 
end

# Variant 2
unless language.chomp == "Ruby"
  puts "Скоро будет Ruby"
else
  puts "Подлиза"
end

# Variant 3
puts "Подлиза" if language.chomp == "Ruby"

# Switch case
case language.chomp
  when "Ruby"
    puts "Красава"
  when "C++"
    puts "Сочувствую"
  when "Английский"
    puts "Хорошая шутка)"
  else puts "Скоро будет Ruby"
end

# Block 1 Task 4
puts "Введите команду ОС:"
command = system "#{gets}"
puts command

puts "Введите команду Ruby:"
command = `ruby "-e#{gets}"`
puts command


# Block 2 Task 1
number = ARGV[0].to_i
sum = 0
while number != 0
  sum += number % 10
  number /= 10
end
puts sum

# Block 2 Task 2
def sum_digits_of_number
  number = ARGV[0].to_i
  sum = 0
  while number != 0
    sum += number % 10
    number /= 10
  end
  puts sum
end

def max_digit
  number = ARGV[0].to_i
  max = number % 10
  while number != 0
    max = number % 10 if number % 10 > max
    number /= 10
  end
  puts max
end

def min_digit
  number = ARGV[0].to_i
  min = number % 10
  while number != 0
    min = number % 10 if number % 10 < min
    number /= 10
  end
  puts min
end

def mult_digits
  number = ARGV[0].to_i
  mult = 1
  while number != 0
    mult *= number % 10
    number /= 10
  end
  puts mult
end

# Block 3 Task 1
def min_elem_in_list(list)
  min = list[0].to_i
  list.each do |elem|
    elem = elem.to_i
    min = elem if elem < min
  end
  puts min
end

def max_elem_in_list(list)
  max = list[0].to_i
  list.each do |elem|
    elem = elem.to_i
    max = elem if elem > max
  end
  puts max
end

def sum_elem_in_list(list)
  sum = 0
  list.each do |elem|
    sum += elem.to_i
  end
  puts sum
end

def mult_elem_in_list(list)
  mult = 1
  list.each do |elem|
    mult *= elem.to_i
  end
  puts mult
end

# Block 3 Task 2

=begin
1-й аргумент программы - метод
2-й аргумент программы - место чтения списка
3-й аргумент программы - адрес файла
=end

def initialization_list
  if ARGV[1] == "keyboard"
    ARGV.clear
    puts "Введите список:"
    list = gets.chomp.split(" ")
  elsif ARGV[1] == "file"
    file = File.new(ARGV[2], "r")
    list = file.gets.chomp.split(" ")
  end
end

case ARGV[0]
  when "M1"
    list = initialization_list
    min_elem_in_list(list)
  when "M2"
    list = initialization_list
    max_elem_in_list(list)
  when "M3"
    list = initialization_list
    sum_elem_in_list(list)
  when "M4"
    list = initialization_list
    mult_elem_in_list(list)
  else
    puts "Hello World"
end
