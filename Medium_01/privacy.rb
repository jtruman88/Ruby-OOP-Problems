=begin

Consider the following class:

class Machine
  attr_writer :switch

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
Modify this class so both flip_switch and the setter method switch= are private methods.

Further Exploration:

Add a private getter for @switch to the Machine class, and add a method to Machine that shows how to use that getter.

=end

class Machine
  def start
    flip_switch(:on)
  end
  
  def stop
    flip_switch(:off)
  end
  
  def display_state
    puts "The machine is #{switch}."
  end
  
  private
  
  attr_accessor :switch
  
  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

test = Machine.new
test.start
test.display_state
test.stop
test.display_state