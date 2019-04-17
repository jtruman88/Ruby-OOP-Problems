# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.

=begin
class Cat
end

Cat.generic_greeting

Expected output:

Hello! I'm a cat!
=end

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

# Further Exploration - What happens if you run kitty.class.generic_greeting? Can you explain this result?

kitty = Cat.new
kitty.class.generic_greeting

# This works because #class returns the name of the class of the object it is called on. Which means Cat is what would be calling generic_greeting. Since Generic_greeting is a class method, this works and prints the expected output.