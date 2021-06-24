class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    matching_indices = []

    @secret_word.each_char.with_index do |chars, idx|
      if char == chars
        matching_indices << idx
      end
    end
    matching_indices

  end

  def fill_indices(char, indices)
    indices.each do |idx|
      @guess_word[idx] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    end
    @attempted_chars << char
    
    matches = get_matching_indices(char)
    fill_indices(char, matches)
    if matches.empty?
    @remaining_incorrect_guesses -= 1
    end
    true
  end

  def ask_user_for_guess
    puts "Enter a char: "
    input = gets.chomp
    self.try_guess(input)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    end
    false
  end

  def lose?
    if remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    false
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    end
    false
  end
  
end
