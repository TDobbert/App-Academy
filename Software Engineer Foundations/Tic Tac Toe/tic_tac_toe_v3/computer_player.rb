class ComputerPlayer

    attr_reader :mark

    def initialize(value)
        @mark = value
    end

    def get_position(legal_positions)
        position = legal_positions.sample
        puts "The Computer's, #{mark}, position chosen is #{position}"
        position
    end
end