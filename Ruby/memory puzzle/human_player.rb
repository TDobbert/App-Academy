class HumanPlayer

    attr_accessor :previous_guess

    def initialize(size)
        previous_guess = nil
    end

    def prompt
        puts "Enter the position of a card to flip: (ex. 0 0)"
    end

    def get_input
        prompt
        gets.chomp.split(" ").map(&:to_i)
    end

    def receive_revealed_card(pos, value)
        #Duck Typing
    end

    def receive_match(previous_guess, current_guess)
        puts "It's a match"
    end
end