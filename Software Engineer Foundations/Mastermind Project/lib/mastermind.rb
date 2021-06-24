require_relative "code"

class Mastermind

    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(guess)
        puts "exact matches: #{@secret_code.num_exact_matches(guess)}"
        puts "near matches: #{@secret_code.num_near_matches(guess)}"
    end

    def ask_user_for_guess
        puts "Enter a code"
        input = gets.chomp
        guess = Code.from_string(input)
        self.print_matches(input)
        @secret_code == guess
    end
end
