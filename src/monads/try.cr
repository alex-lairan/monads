module Monads
  class Try(T)
    @final_value : T?
    @final_error : Exception?

    def initialize(proc)
      @final_value = proc.call
    rescue exception
      @final_error = exception
    end

    def to_maybe
      if final_value = @final_value
        Just.new(final_value)
      else
        Nothing(T).new
      end
    end

    def to_either
      if final_value = @final_value
        Right.new(final_value)
      else
        LeftException.new @final_error.not_nil!
      end
    end
  end
end
