# Block 1 Task 1
puts "Hello World"

# Block 1 Task 2
puts "Введите имя пользователя:"
name = gets
puts "Hello, #{name}"

# Block 1 Task 3
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
input = gets
command = system "#{input}"
puts command

puts "Введите команду Ruby:"
input = gets
command = `ruby "-e#{input}"`
puts command
