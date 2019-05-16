module Monads
  struct Task(T)
    enum Message
      None,
      Value,
      Error
    end

    class InvalidMessage < Exception
      def initialize(msg = "Message is invalid")
        super(msg)
      end
    end

    @final_value : T?
    @final_error : Exception?

    @kind = Message::None

    def initialize(proc)
      @channel_message = channel_message = Channel::Buffered(Message).new
      @channel_value = channel_value = Channel::Buffered(T).new
      @channel_error = channel_error = Channel::Buffered(Exception).new
      @final_value = nil
      @final_error = nil

      spawn do
        begin
          value = proc.call
          channel_message.send Message::Value
          channel_value.send value
        rescue exception
          channel_message.send Message::Error
          channel_error.send exception
        end
      end
    end

    def bind(lambda : T -> U) : U forall U
      lambda.call(receive)
    end

    def receive : T
      case @kind
      when Message::None
        @kind = @channel_message.receive
        receive
      when Message::Value
        @final_value = @channel_value.receive unless @final_value
        @final_value.not_nil!
      when Message::Error
        @final_error = @channel_error.receive unless @final_error
        raise @final_error.not_nil!
      else
        raise InvalidMessage.new
      end
    end

    def to_maybe
      Just.new receive
    rescue
      Nothing(T).new
    end

    def to_either
      Right.new receive
    rescue exception
      LeftException.new exception
    end
  end
end
