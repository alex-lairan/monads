module Monads
  struct Task(T)
    @result : Try(T)? = nil

    def initialize(proc)
      @channel = channel = Channel(Try(T)).new

      spawn do
        value = Try(T).new(proc)
        channel.send value
      end
    end

    def receive : Try(T)
      if result = @result
        result
      else
        @result = @channel.receive
        receive
      end
    end

    def to_maybe
      receive.to_maybe
    end

    def to_either
      receive.to_either
    end
  end
end
