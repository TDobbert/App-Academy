require_relative 'player'
require 'byebug'

class PokerGame
  attr_reader :players, :current_player, :deck, :pot, :current_bet

  STRAIGHT_OR_FLUSH = [22, 19, 18].freeze

  def initialize(players)
    @players = players
    @current_player = @players.first
    @deck = Deck.new
    @pot = 0
    @current_bet = 0
  end

  def play
    take_turn until game_over?
    winner
  end

  private

  def current_player_hand
    @current_player.hand.current_hand
  end

  def deal_cards
    @players.each do |player|
      next unless player.hand.current_hand.empty?

      5.times { player.hand.current_hand << @deck.draw_card }
    end
  end

  def render_hand
    current_player_hand.each do |card|
      print "#{card.card_value[1]}#{card.card_suit}"
    end
  end

  def ante
    return unless pot.zero?

    initial_bet = 1
    @players.each do |player|
      @pot += player.place_bet(initial_bet)
      player.subtract_bet(initial_bet)
    end
  end

  def take_turn
    ante
    deal_cards
    take_turn_to_discard_cards
    play_round
    determine_winning_hand
    delete_losing_player
    reset_game
  end

  def play_round
    until end_round
      next if @current_player.folded

      make_choice
      actions_when_player_raised
      switch_players
    end
  end

  def actions_when_player_raised
    return unless @players.one?(&:raised)

    unraised_players = @players.reject(&:raised)

    until unraised_players.all? { |player| player.called || player.folded }
      puts 'Must call or fold when another player has raised.'
      switch_players
      make_choice
    end
    reset_raise_and_call
  end

  def reset_raise_and_call
    @players.each do |player|
      player.unraise
      player.uncall
    end
  end

  def switch_players
    rotated_players = @players.rotate!
    @current_player = rotated_players.first
  end

  def take_turn_to_discard_cards
    @players.length.times do
      render_hand
      option_to_discard_cards
      sleep(2)
      system('clear')
      switch_players
    end
  end

  def option_to_discard_cards
    input = nil
    until input && valid_input_to_discard_cards(input)
      puts ''
      puts "Would you like to discard any cards #{@current_player.name}? y/n"
      input = gets.chomp
    end
    case_to_discard_cards(input)
  end

  def case_to_discard_cards(input)
    case input
    when 'y'
      discard_and_replace_cards
      render_hand
      puts ''
    when 'n'
      render_hand
      puts ''
    end
  end

  def valid_input_to_discard_cards(input)
    valid_options = %w[y n]
    valid_options.include?(input)
  end

  def discard_and_replace_cards
    card_indices = @current_player.discard_cards
    current_player_hand.delete_if.with_index do |_card, i|
      card_indices.include?(i)
    end

    card_indices.length.times { current_player_hand << @deck.draw_card }
  end

  def get_choice
    puts ''
    puts "#{@current_player.name}s turn, Bank: #{@current_player.bank}"
    puts 'r to raise, c to call, f to fold, or h to hold'
    gets.chomp
  end

  def make_choice
    input = get_choice
    case input
    when 'r'
      choice_to_raise
    when 'c'
      @current_player.call
      add_subtract_bet
    when 'f'
      @current_player.hand.hand_rank = 0
      @current_player.fold
    when 'h'
      determine_hand_ranking
      @current_player.hold
    end
  end

  def choice_to_raise
    @current_bet = 1
    @current_player.to_raise
    @current_player.hold
    add_subtract_bet
  end

  def add_subtract_bet
    @pot += @current_player.place_bet(@current_bet)
    @current_player.subtract_bet(@current_bet)
  end

  def player_with_best_hand
    select_players_with_best_hands.pop
  end

  def determine_winning_hand
    winning_round(player_with_best_hand) if single_winning_hand?(map_sort_ranks)

    winning_round(determine_winner_of_tie)
  end

  def single_winning_hand?(ranks)
    ranks.uniq.length == players.length && ranks.max == ranks.last
  end

  def winning_round(winner)
    winner.add_winnings(pot)
    puts "#{winner.name} wins this round!"
    sleep(2)
    system('clear')
  end

  def map_sort_ranks
    @players.map do |player|
      player.hand.hand_rank
    end.sort
  end

  def select_players_with_best_hands
    ranks = map_sort_ranks
    @players.select { |player| player if player.hand.hand_rank == ranks.max }
  end

  def determine_hand_ranking
    @players.each do |player|
      next if player.folded

      hand = player.hand
      hand.hand_rank = hand.determine_rank
    end
  end

  def determine_winner_of_tie
    ranks = map_sort_ranks
    best_players = select_players_with_best_hands

    best_players.each do |player|
      hand = player.hand
      next if player.folded || hand.hand_rank < ranks.max

      high_card_tie(hand, ranks)
      straight_or_flush_tie(hand, ranks)

      hand.hand_rank += hand.high_pair.first
    end
    player_with_best_hand
  end

  def high_card_tie(hand, ranks)
    return unless ranks.all? { |rank| rank < 15 } && ranks.uniq.length == 1

    hand.hand_rank += hand.high_suit
  end

  def straight_or_flush_tie(hand, ranks)
    hand.hand_rank += hand.high_card if STRAIGHT_OR_FLUSH.include?(ranks.max)
  end

  def end_round
    @players.all? { |player| player.holding || player.folded }
  end

  def reset_game
    @deck = Deck.new
    @current_player = @players.first
    @pot = 0
    @current_bet = 0
    reset_player
  end

  def reset_player
    @players.each do |player|
      player.hand.current_hand = []
      player.hand.hand_rank = 0
      deal_cards
      player.unfold
      player.unhold
    end
  end

  def game_over?
    @players.length == 1
  end

  def delete_losing_player
    @players = @players.select { |player| player unless player.lost? }
  end

  def winner
    puts "#{@players.first.name} wins!"
  end

  def valid_choice_input(input)
    valid_options = %w[r s f h]
    input.include?(valid_options)
  end
end

players = [
  Player.new('Tom'),
  Player.new('Rob'),
  Player.new('Jim')
]
if __FILE__ == $PROGRAM_NAME
  game = PokerGame.new(players)
  game.play
end
