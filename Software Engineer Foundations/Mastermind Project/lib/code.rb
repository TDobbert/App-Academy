class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(chars_array)
    chars_array.all? do |char|
      POSSIBLE_PEGS.has_key?(char.upcase)
    end
  end

  def self.random(length)
    random = []

    length.times {random << POSSIBLE_PEGS.keys.sample}
    Code.new(random)
  end

  def self.from_string(pegs_str)
    Code.new(pegs_str.split(""))
  end

  def initialize(pegs)
    
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map(&:upcase)
    else
      raise "Invalid pegs"
    end
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    count = 0

    (0...guess.length).each do |i|
        if guess[i] == self[i]
          count += 1
        end
    end
    count
  end

  def num_near_matches(guess)
        count = 0

    (0...guess.length).each do |i|
        if @pegs.include?(guess[i]) && guess[i] != @pegs[i]
          count += 1
        end
    end
    count
  end

  def ==(instance)
    self.pegs == instance.pegs
  end

end
