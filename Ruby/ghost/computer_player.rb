class ComputerPlayer

    attr_reader :name
    ALPHABET = ('a'..'z').to_a

    def initialize(name)
        @name = name
    end

    def guess(fragment, dictionary, num_players)
        puts "The current fragment is: #{fragment}"
        puts "#{@name}, Enter a letter: "
        letter = ALPHABET.sample

        return letter if fragment == ""
        words = dictionary.select {|word| word.start_with?(fragment)}
        words.each do |word| 
            if word.length - fragment.length < num_players && !dictionary.include?(word[0..fragment.length])
                cpu_guess = word[fragment.length]
                return cpu_guess
            end
        end
        words.sample[fragment.length]
    end

    def alert_invalid_guess(fragment)
        puts "#{fragment} is invalid, try again."
    end
end