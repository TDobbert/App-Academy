class Employee
  attr_reader :name, :title, :salary
  attr_accessor :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    self.boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :subordinates

  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @subordinates = []
  end

  def add_subordinates(employee)
    @subordinates << employee
  end

  def bonus(multiplier)
    subs_salaries = 0
    @subordinates.each { |employee| subs_salaries += employee.salary }
    subs_salaries * multiplier
  end
end
