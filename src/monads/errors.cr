module Monads
  class UnwrapError < Exception
    def initialize(method : String, klass : String)
      super("#{method} was called for #{klass}")
    end
  end
end
