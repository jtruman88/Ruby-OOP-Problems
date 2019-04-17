# Using the following code, add an instance method named #rename that renames kitty when invoked.

=begin
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name
=end

class Cat
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def rename(n)
    self.name = n
  end
end

kitty = Cat.new("Sophie")
puts kitty.name
kitty.rename("Chloe")
puts kitty.name