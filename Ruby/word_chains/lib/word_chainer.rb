require 'set'

class WordChainer
  ALPHA = ('a'..'z').to_a
  attr_reader :dictionary

  def initialize(filename)
    words = File.readlines(filename).map(&:chomp)
    @dictionary = Set.new(words)
  end

  def adjacent_words(word)
    words = []

    (0...word.length).each do |i|
      ALPHA.each do |alpha_letter|
        possible_word = word.dup
        possible_word[i] = alpha_letter
        words << possible_word if @dictionary.include?(possible_word) && possible_word != word
      end
    end
    words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {}
    @all_seen_words[source] = nil

    until @current_words.empty? && @all_seen_words.key?(target)
      new_current_words = explore_current_words
      @current_words = new_current_words
    end

    build_path(target)
  end

  def explore_current_words
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |word|
        next if @all_seen_words.include?(word)

        new_current_words << word
        @all_seen_words[word] = current_word
      end
    end

    new_current_words
  end

  def build_path(target)
    path = [target]

    until @all_seen_words[target].nil?
      previous_word = @all_seen_words[target]
      path << previous_word
      target = previous_word
    end
    path.reverse
  end
end

chain = WordChainer.new('dictionary.txt')
puts chain.run('duck', 'ruby')
