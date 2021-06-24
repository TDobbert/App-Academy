class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until @game_over == true

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message if @game_over == false
    @sequence_length += 1
  end

  def show_sequence
    add_random_color

    seq.each do |i|
      puts i
      sleep(1)
      system('clear')
    end
  end

  def require_sequence
    puts 'list the colors in the sequence (ex. red blue green)'
    input = gets.chomp

    @game_over = true unless input == seq.join(' ')
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts 'This round was a success'
  end

  def game_over_message
    puts 'Game over, man'
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

game = Simon.new
game.play
