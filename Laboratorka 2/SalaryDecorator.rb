# Общий интерфейс
class Salary
  # Метод обёртки
  def Salary.get_instance(salary:, bonus_percent:, bonus_rub:, premium:, fine:)
    salary = Fixed_salary.new(salary)
    salary = Bonus_percent.new(salary, bonus_percent) if bonus_percent != nil
    salary = Bonus_rub.new(salary, bonus_rub) if bonus_rub !=nil
    salary = Premium.new(salary, premium) if premium != nil
    salary = Fine.new(salary, fine) if fine != nil
    salary
  end

  def get_salary
  end
end

# Конкретный компонент, определяет базовое поведение
class Fixed_salary < Salary
  def initialize(salary)
    @salary = salary
  end

  def get_salary
    @salary
  end
end

# Базовый декоратор
class SalaryDecorator < Salary
  def initialize(salary_obj)
    @salary = salary_obj
  end

  def get_salary
    @salary.get_salary
  end
end

class Bonus_rub < SalaryDecorator
  def initialize(salary_obj, bonus_rub)
    super(salary_obj)
    @bonus_rub = bonus_rub
  end

  def get_salary
    super + @bonus_rub
  end
end

class Bonus_percent < SalaryDecorator
  def initialize(salary_obj, bonus_percent)
    super(salary_obj)
    @bonus_percent = bonus_percent
  end

  def get_salary
    if rand(2) == 0
      super
    else
      super + (super * @bonus_percent/100).to_i
    end
  end
end

class Fine < SalaryDecorator
  def initialize(salary_obj, fine)
    super(salary_obj)
    @fine = fine
  end

  def get_salary
    super - (super * @fine/100).to_i
  end
end

class Premium < SalaryDecorator
  def initialize(salary_obj, premium_percent)
    super(salary_obj)
    @premium_percent = premium_percent
  end

  def get_salary
    super + (super * @premium_percent/100).to_i
  end
end
