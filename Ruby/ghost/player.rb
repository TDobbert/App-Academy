class Player

    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess(fragment, dictionary, num_players)
        puts "The current fragment is: #{fragment}"
        puts "#{@name}, Enter a letter: "
        gets.chomp.downcase
    end

    def alert_invalid_guess(fragment)
        puts "#{fragment} is invalid, try again."
    end
end