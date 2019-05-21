require "./monad"

module Monads
  struct State(S, T)
    def initialize(@transition : S -> {T, S})
    end

    def self.return(val : T) : State(S, T)
      State.new(->(s : S) { {val, s} })
    end

    def bind(lambda : T -> State(S, U)) : State(S, U) forall U
      State.new(->(s : S) {
        val, new_s = @transition.call(s)
        new_transition = lambda.call(val).transition
        new_transition.call(new_s)
      })
    end

    def transition : S -> {T, S}
      @transition
    end

    def to_s
      "#{typeof(self)}@#{typeof(transition)}"
    end

    def inspect(io)
      io << to_s
    end

    def run(val : S) : {T, S}
      @transition.call(val)
    end
  end
end