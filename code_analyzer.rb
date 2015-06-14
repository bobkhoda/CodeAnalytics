
# class TV
#   def turnOn
#     context.turnOn
#   end
#   def turnOff
#     context.turnOff
#   end
# end

# class On::TV
#   def turnOn
#     puts "on"
#     return self
#   end
#   def turnOff
#     puts "off"
#     return self
#   end
# end

# class Off::TV
#   def turnOn
#     puts "on"
#     return self
#   end

#   def turnOff
#     return self
#   end
# end

# class Context
#   attr_accessor :currentState
#   def initialize
#     @currentState = TV.new
#   end 
#   def turnOn
#     @currentState = @currentState.turnOn
#   end

#   def turnOff
#     @currentState = @currentState.turnOff
#   end
# end

# c = Context.new
# c.turnOn
  #// "State" 
  class State
    def Handle(context)
    end
  end

  #// "ConcreteStateA" 
  class ConcreteStateA < State
    def Handle(context)
      puts "A -> B"
      context.state = ConcreteStateB.new
    end
  end

  #// "ConcreteStateB" 
  class ConcreteStateB < State
    def Handle(context)
      puts "B -> A"
      context.state = ConcreteStateA.new
    end
  end

  #// "Context" 
  class Context
    #// Constructor 
    def initialize(state)
      @state = state;
    end
    attr_accessor :state

    def Request
      state.Handle(self);
    end
  end

# class MainApp
  #// Setup context in a state 
  c = Context.new(ConcreteStateA.new)

  #// Issue requests, which toggles state 
  c.Request()
  c.Request()
  c.Request()
  c.Request()
# end
