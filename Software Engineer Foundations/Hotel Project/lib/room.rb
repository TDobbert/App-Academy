class Room

        def initialize(num)
        @capacity = num
        @occupants = []
    end

    def capacity
        @capacity
    end

    def occupants
        @occupants
    end

    def full?
        if @occupants.length < @capacity
            return false
        end
        true
    end

    def available_space
        @capacity - @occupants.length
    end

    def add_occupant(name)
        if self.full? == false
            @occupants << name
            return true
        end
        false
    end
end
