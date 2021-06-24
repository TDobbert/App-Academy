class Card

    CARD_VALUES = ("A".."Z").to_a

    def self.shuffled_pairs(num_pairs)
        card_values = CARD_VALUES.shuffle
        card_values = card_values[0...num_pairs]
        card_values = card_values * 2
        card_values.shuffle!
        card_values.map { |val| self.new(val) }
    end

    attr_reader :card_value, :face_up

    def initialize(card_value)
        @card_value = card_value
        @face_up = false
    end

    def to_s
        face_up ? @card_value : " "
    end

    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end

    def face_up?
        @face_up
    end

    def ==(other)
        self.card_value == other.card_value
    end
end