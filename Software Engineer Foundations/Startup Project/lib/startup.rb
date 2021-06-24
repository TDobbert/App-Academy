require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(another_startup)
        if self.funding > another_startup.funding
            return true
        end
        false
    end

    def hire(employee_name, title)
        if self.valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise "title is invalid"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding >= salaries[employee.title]
            employee.pay(salaries[employee.title])
            @funding -= salaries[employee.title]
        else
            raise "Sorry, not enough funding"
        end
    end

    def payday
        self.employees.each {|employee| pay_employee(employee)}
    end

    def average_salary
        sum = 0
        employees.each do |employee|
           sum += @salaries[employee.title]
        end
        sum / employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        @funding += other_startup.funding
        
        other_startup.salaries.each do |title, salary|
            if !@salaries.has_key?(title)
                @salaries[title] = salary
            end
        end

        @employees += other_startup.employees
        other_startup.close
    end
end
