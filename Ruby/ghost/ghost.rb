require "set"
require_relative "player"
require_relative "computer_player"

class GhostGame
    
    attr_reader :players, :fragment, :dictionary, :losses

    ELIMINATION_COUNT = 5
    ALPHABET = ('a'..'z').to_a

    def initialize(*players)
        @players = players
        @fragment = fragment
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Set.new(words)
        @losses = Hash.new {|losses, player| losses[player] = 0}
    end
    
    def run
        while !game_over?
            play_round
        end

        puts "#{winner} wins!"
    end

    def play_round
        @fragment = ""
        puts "Let's play Ghost."

        while !@dictionary.include?(@fragment)
            take_turn
            next_player!
        end

        new_standings
    end

    def current_player
        @players.first
    end

    def previous_player
        (@players.count - 1).downto(0).each do |idx|
            player = players[idx]
            return player if @losses[player] < ELIMINATION_COUNT
        end
    end

    def next_player!
        @players.rotate!
        @players.rotate! until @losses[current_player] < ELIMINATION_COUNT
    end

    def remaining_players
        @losses.count { |_, v| v < ELIMINATION_COUNT }
    end

    def winner
        (player, _) = @losses.find { |_, losses| losses < ELIMINATION_COUNT }
        player.name
    end

    def valid_play?(letter)
        return false if !ALPHABET.include?(letter)

        possible_fragment = fragment + letter
        @dictionary.any? {|word| word.start_with?(possible_fragment)}
    end

    def take_turn
        letter = nil

        until letter
            letter = current_player.guess(fragment, @dictionary, @players.length)
        
            if !valid_play?(letter)
                current_player.alert_invalid_guess(letter)
                letter = nil
            end
        end

        @fragment += letter
    end

    def new_standings
        puts "#{previous_player.name} spelled #{fragment}."
        puts "#{previous_player.name} loses this round!"

        puts "#{previous_player.name} is elimnated!" if @losses[previous_player] == ELIMINATION_COUNT - 1
        @losses[previous_player] += 1
        display_standings
    end

    def display_standings
        puts "Current Standings: "
        @losses.each { |k, v| puts "#{k.name} = #{"GHOST".slice(0, v)}" }
    end

    def game_over?
        remaining_players == 1
    end
end

if $PROGRAM_NAME == __FILE__
  game = GhostGame.new(
    Player.new("Dwight"), 
    Player.new("Jim"), 
    Player.new("Pam"),
    Player.new("Michael"),
    ComputerPlayer.new("CPU")
    )

  game.run
end