class ComputerPlayer
	attr_accessor :previous_guess, :board_size

	def initialize(size)
		@board_size = size
    	@matched_cards = {}
    	@known_cards = {}
    	@previous_guess = nil
  	end

  	def receive_revealed_card(pos, value)
    	@known_cards[pos] = value
  	end

  	def receive_match(pos1, pos2)
    	@matched_cards[pos1] = true
    	@matched_cards[pos2] = true
  	end

  	def get_input
  		@previous_guess ? second_guess : first_guess
  	end

  	def unmatched_pos
		result = @known_cards.find do |pos_1, val_1|
      		@known_cards.any? do |pos_2, val_2|
        		(pos_1 != pos_2 && val_1 == val_2) && !(@matched_cards[pos_1] || @matched_cards[pos_2])
      		end
    	end
    result[0] if result
  	end

  	def match_previous
    	result = @known_cards.find do |pos, val|
      	pos != previous_guess && val == @known_cards[previous_guess] && !@matched_cards[pos]
    	end
    result[0] if result
  	end

  	def first_guess
    	unmatched_pos || random_guess
  	end

  	def second_guess
   		match_previous || random_guess
  	end

  	def random_guess
    	guess = nil

    	until guess && !@known_cards[guess]
      		guess = [rand(board_size), rand(board_size)]
    	end

    guess
  	end
end
