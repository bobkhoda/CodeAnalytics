#"TV" 
# class TVAbstraction
#   def toggle(TVController)
#   end
# end

#"On" 
class On #< TVAbstraction
  def toggle(tv_controller)
    puts "On -> Off"
    tv_controller.state = Off.new
  end
end

#"Off" 
class Off #< TVAbstraction
  def toggle(tv_controller)
    puts "Off -> On"
    tv_controller.state = On.new
  end
end

#"TVController" 
class TVController
  #Constructor 
  attr_accessor :state
  def initialize(state)
    @state = state;
  end

  def push_power_button
    state.toggle(self);
  end
end

class UserOfTVController
#Setup TVController in an initial state 
  def initialize
    @tv_controller = TVController.new(Off.new)
  end

  def use_controller
    #call push_power_buttons, which toggles state 
    @tv_controller.push_power_button()
    @tv_controller.push_power_button()
    @tv_controller.push_power_button()
    @tv_controller.push_power_button()
  end
end

bob = UserOfTVController.new
bob.use_controller
