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
def sum_digits_of_number(number)
  sum = 0
  while number != 0
    sum += number % 10
    number /= 10
  end
  sum
end

def max_digit(number)
  max = number % 10
  while number != 0
    max = number % 10 if number % 10 > max
    number /= 10
  end
  max
end

def min_digit(number)
  min = number % 10
  while number != 0
    min = number % 10 if number % 10 < min
    number /= 10
  end
  min
end

def mult_digits(number)
  mult = 1
  while number != 0
    mult *= number % 10
    number /= 10
  end
  mult
end

# Block 2 Task 3
# Найти количество четных чисел, не взаимно простых с данным
def kolvo_chet_not_simple(number)
  kolvo = 0
  even_num = 2
  while even_num < number
    if nod(number, even_num) != 1
      kolvo += 1
    end
    even_num += 2
  end
  kolvo
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
def max_digit_not_div_3(number)
  max = 0
  while number != 0
    if number % 10 > max and number % 10 % 3 != 0
      max = number % 10
    end
    number /= 10
  end
  max
end

=begin
Найти произведение максимального числа, не взаимно простого
с данным, не делящегося на наименьший делитель исходно числа, и
суммы цифр числа, меньших 5
=end
def mult_max_num_and_sum(number)
  # Наименьший делитель исходного числа
  def min_del(number)
    del = 2
    while number % del != 0
      del += 1
    end
    del
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
    sum
  end

  max_num(number, del, max) * sum_digits_less_5(number)
end

case ARGV[0]
  when "M1"
    puts kolvo_chet_not_simple(ARGV[1].to_i)
  when "M2"
    puts max_digit_not_div_3(ARGV[1].to_i)
  when "M3"
    puts mult_max_num_and_sum(ARGV[1].to_i)
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
  min
end

def max_elem_in_list(list)
  max = list[0].to_i
  list.each do |elem|
    elem = elem.to_i
    max = elem if elem > max
  end
  max
end

def sum_elem_in_list(list)
  sum = 0
  list.each do |elem|
    sum += elem.to_i
  end
  sum
end

def mult_elem_in_list(list)
  mult = 1
  list.each do |elem|
    mult *= elem.to_i
  end
  mult
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
    puts min_elem_in_list(list)
  when "M2"
    list = initialization_list
    puts max_elem_in_list(list)
  when "M3"
    list = initialization_list
    puts sum_elem_in_list(list)
  when "M4"
    list = initialization_list
    puts mult_elem_in_list(list)
  else
    puts "Hello World"
end

# Block 4 Task 4
=begin
Дан целочисленный массив. Вывести индексы массива в том
порядке, в котором соответствующие им элементы образуют
убывающую последовательность
=end

def ind_of_decreasing_sequence(array)
  array_with_index = array.map.with_index.max(array.length)
  # Массив индексов
  array_with_index.map {|elem| elem.pop}
end

# Block 4 Task 16
=begin
Дан целочисленный массив. Необходимо найти элементы,
расположенные между первым и вторым максимальным
=end
def between_fir_sec_max(array)
  # Создаётся массив двух максимальных элементов с их индексами
  first_second_max = array.map.with_index.max(2)
  # Массив индексов двух максимальных
  array_ind = first_second_max.map {|elem| elem.pop}
  length = (array_ind[0] - array_ind[1]).abs
  if array_ind[0] > array_ind[1]
    array.slice(array_ind[1] + 1, length - 1)
  else
    array.slice(array_ind[0] + 1, length - 1)
  end
end

# Block 4 Task 28
=begin
Дан целочисленный массив. Необходимо найти элементы,
расположенные между первым и последним максимальным
=end
def between_fir_last_max(array)
  # Создание массива из индексов первого и последнего максимального
  array_ind = Array(array.index(array.max))
  array_ind.push(array.index(array.min))
  # Выбираются элементы между первым и последним максимальным
  length = (array_ind[0] - array_ind[1]).abs
  if array_ind[0] > array_ind[1]
    array.slice(array_ind[1] + 1, length - 1)
  else
    array.slice(array_ind[0] + 1, length - 1)
  end
end

# Block 4 Task 40
=begin
Дан целочисленный массив. Необходимо найти минимальный
четный элемент
=end
def even_min(array)
  if array != []
    if array.min % 2 == 0
      array.min
    else
      array.delete(array.min)
      even_min(array)
    end
  else
    puts "Такого нет"
  end
end

# Block 4 Task 52
=begin
Для введенного числа построить список всех его простых делителей,
причем если введенное число делится на простое число p в степени a,
то в итоговом списке число p должно повторятся a раз.
Результирующий список должен быть упорядочен по возрастанию
=end

# Проверка на простое число
def check_prime(number) = (2..number-1).select {|del| number % del == 0}.empty?

# Поиск степени, при возведении делителя в которую введённое число делится на него
def power(number, del, k)
  if number % del**k == 0
    power(number, del, k+1)
  else
    k - 1
  end
end

def result_list(number)
  # Создание списка простых делителей
  list = (2..number).select {|del| number % del == 0 && check_prime(del) == true}
  result = []
  list.select {|elem| power(number, elem, 2).times {result.push(elem)}}
  result
end

def initialization
  if ARGV[1] == "keyboard"
    ARGV.clear
    puts "Введите массив:"
    array = gets.chomp.split(" ")
  elsif ARGV[1] == "file"
    file = File.new(ARGV[2], "r")
    array = file.gets.chomp.split(" ")
  end
end

case ARGV[0]
  when "M1"
    array = initialization
    print ind_of_decreasing_sequence(array)
  when "M2"
    array = initialization
    puts between_fir_sec_max(array)
  when "M3"
    array = initialization
    puts between_fir_last_max(array)
  when "M4"
    array = initialization
    puts even_min(array)
  when "M5"
    number = initialization
    print result_list(number.first.to_i)
  else
    puts "Ошибка, метод некорректен"
end

  
# Block 5 Task 4
=begin
Дана строка. Необходимо проверить, является ли она палиндромом
=end
def check_palindrom(string) = string == string.reverse
  
# Block 5 Task 11
=begin
Дана строка в которой записаны слова через пробел. Необходимо
посчитать количество слов
=end
def num_words(string) = string.split(" ").length
  
# Block 5 Task 15
=begin
Дано натуральное число. Необходимо найти количество различных
цифр в его десятичной записи
=end
def num_diff_digits(number) = number.to_s.split("").uniq.length
  
# Block 5 Final Task 2
=begin
Дана строка. Необходимо найти все даты, которые описаны в
виде "31 февраля 2007"
=end
def dates_in_string(string)
  string.scan(/
    \s+((?:[1-9]|[12][\d]|[3][01])
    \s+(?:декабря|января|февраля|марта|апреля|мая|июня|июля|августа|сентября|октября|ноября)
    \s+\d{1,4})/ixu)
end
  
# Block 5 Final Task 4
=begin
Дана строка. Необходимо подсчитать количество чисел в этой
строке, значение которых меньше 5
=end
def amount_num_less_5(string) = string.scan(/\d+/).select {|num| num.to_i < 5}.length
  
# Block 5 Final Task 11
=begin
Дана строка. Необходимо найти все незадействованные символы
латиницы в этой строке
=end
def unused_chars(string) = ("a".."z").to_a - string.scan(/[a-z]/)
  
# Block 5 Final Task 15
=begin
Дана строка. Необходимо подсчитать количество цифр в этой
строке, значение которых больше 5
=end
def amount_digits_more_5(string) = string.scan(/\d/).count {|digit| digit.to_i > 5}
  
# Block 6 Task 1
# Дан список строк из файла. Упорядочить по длине строки
file = File.new(ARGV[0], "r")
listString = file.readlines.map {|string| string.chomp}
.sort {|a,b| a.length <=> b.length}

# Block 6 Task 2
# Дан список строк. Упорядочить по количеству слов в строке
listString = file.readlines.map {|string| string.chomp}
.sort {|a,b| a.split(" ").length <=> b.split(" ").length}

# Block 6 Task 3.1
=begin
Отсортировать строки в порядке увеличения разницы между средним количеством
согласных и средним количеством гласных букв в строк
=end

# Получение разницы между ср. количеством согласных и гласных
def differenceConVow(string)
  vowel = "eyuoai"
  averageVow = string.split("").select {|letter| vowel.include?(letter)}.length / string.length.to_f
  averageCon = string.split("").select {|letter| !vowel.include?(letter)}.length / string.length.to_f
  difference = (averageCon - averageVow).abs
end

def sortDiffConVow(file) = listString = file.readlines.map {|string| string.chomp}
.sort {|a,b| differenceConVow(a) <=> differenceConVow(b)}

