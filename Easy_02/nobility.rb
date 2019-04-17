=begin

Now that we have a Walkable module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.

We need a new class Noble that shows the title and name when walk is called:

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
We must have access to both name and title because they are needed for other purposes that we aren't showing here.

byron.name
=> "Byron"
byron.title
=> "Lord"

=end

# Initial Solution

=begin
module Walkable
  def walk
    puts "#{self} #{gait} forward"
  end
end

class Person
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  include Walkable
  
  attr_reader :name, :title
  
  def initialize(name, title)
    @name = name
    @title = title
  end
  
  def to_s
    "#{title} #{name}"
  end
  
  private
  
  def gait
    "struts"
  end
end

mike = Person.new("Mike")
mike.walk

kitty = Cat.new("Kitty")
kitty.walk

flash = Cheetah.new("Flash")
flash.walk

byron = Noble.new("Byron", "Lord")
byron.walk

=end

# Further Exploration - This exercise can be solved in a similar manner by using inheritance; a Noble is a Person, and a Cheetah is a Cat, and both Persons and Cats are Animals. What changes would you need to make to this program to establish these relationships and eliminate the two duplicated #to_s methods?

module Walkable
  def walk
    puts "#{full_name} #{gait} forward"
  end
end

class Animal
  attr_reader :name
  
  include Walkable
  
  def initialize(name)
    @name = name
  end
  
  def full_name
    name
  end
  
  private
  
  def gait
    "walks"
  end
end

class Person < Animal
  private
  
  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title
  
  def initialize(name, title)
    super(name)
    @title = title
  end
  
  def full_name
    "#{title} #{name}"
  end
  
  private
  
  def gait
    "struts"
  end
end

class Cat < Animal
  private
  
  def gait
    "saunters"
  end
end

class Cheetah < Cat
  private
  
  def gait
    "runs"
  end
end

jaron = Person.new("Jaron")
jaron.walk

truman = Noble.new("Truman", "Master")
truman.walk

lady = Cat.new("Lady")
lady.walk

spots = Cheetah.new("Spots")
spots.walk