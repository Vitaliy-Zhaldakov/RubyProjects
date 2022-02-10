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

# Block 2 Task 3
# Найти количество четных чисел, не взаимно простых с данным
def kolvo_chet_not_simple
  number = ARGV[1].to_i
  kolvo = 0
  even_num = 2
  while even_num < number
    if nod(number, even_num) != 1
      kolvo += 1
      puts even_num
    end
    even_num += 2
  end
  puts kolvo
end

# Вычисление наибольшего общего делителя
def nod(num1, num2)
  if num1 % num2 == 0
    num2
  else
    nod(num2, num1 % num2)
  end
end

# Найти максимальную цифру числа, не делящуюся на 3
def max_digit_not_div_3
  number = ARGV[1].to_i
  max = 0
  while number != 0
    if number % 10 > max and number % 10 % 3 != 0
      max = number % 10
    end
    number /= 10
  end
  puts max
end

=begin
Найти произведение максимального числа, не взаимно простого
с данным, не делящегося на наименьший делитель исходно числа, и
суммы цифр числа, меньших 5
=end
def mult_max_num_and_sum
  number = ARGV[1].to_i
  # Наименьший делитель исходного числа
  def min_del(number)
    del = 2
    while number % del != 0
      del += 1
    end
    return del
  end

  del = min_del(number)
  max = number - 1

  # Максимальное число, не взаимно простое с данным и
  # не делящееся на наименьший делитель
  def max_num(number, del, max)
    while nod(number, max) == 1
      max -= 1
    end
    if max % del != 0
      return max
    else
      max_num(number, del, max - 1)
    end
  end

  # Сумма цифр числа, меньших 5
  def sum_digits_less_5(number)
    sum = 0
    while number != 0
      sum += number % 10 if number % 10 < 5
      number /= 10
    end
    return sum
  end

  puts max_num(number, del, max) * sum_digits_less_5(number)
end

case ARGV[0]
  when "M1"
    kolvo_chet_not_simple
  when "M2"
    max_digit_not_div_3
  when "M3"
    mult_max_num_and_sum
  else
    puts "Hello World"
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

# Block 4 Task 4
=begin
Дан целочисленный массив. Вывести индексы массива в том
порядке, в котором соответствующие им элементы образуют
убывающую последовательность
=end

=begin
Поиск максимального элемента в каждой итерации,
выводится его индекс по хэшу, удаляется из массива 
=end
def ind_of_decreasing_sequence(array, hash)
  if array != []
    max = array.max
    array.delete(max)
    print "#{hash.key(max)} "
    ind_of_decreasing_sequence(array, hash)
  end
end
