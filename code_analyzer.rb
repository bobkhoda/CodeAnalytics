#TV abstraction do I need this???" 
# class TVAbstraction
#   @@called = 0
#   def toggle(tv_controller)
#   end
# end

#"On state" 
class On #< TVAbstraction
  def toggle(tv_controller)
    # @@called += 1
    tv_controller.state = Off.new
  end
  # def called
  #   puts "called: #{@@called}"
  # end
end

#"Off state" 
class Off #< TVAbstraction
  def toggle(tv_controller)
    # @@called += 1
    tv_controller.state = On.new
  end
  # def called
  #   puts "called: #{@@called}"
  # end
end

#"TVController" 
class TVController
  attr_accessor :state
  def initialize(state)
    @state = state;
  end

  def push_power_button
    puts "current state: #{@state.class.name}"
    state.toggle(self)
    puts "state after toggle: #{@state.class.name}"
    # state.called
    # puts ""
  end
end

class UserOfTVController
  def initialize
    #Setup TVController in an initial state 
    @tv_controller = TVController.new(Off.new)
  end

  def use_controller
    #call push_power_buttons, which toggles state 
    (1..5).each{@tv_controller.push_power_button()}
  end
end

bob = UserOfTVController.new
bob.use_controller
