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
