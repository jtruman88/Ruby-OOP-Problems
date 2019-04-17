=begin

Consider the following classes:

class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end
Refactor these classes so they all use a common superclass, and inherit behavior as needed.

=end

class Vehicle
  attr_reader :make, :model
  
  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def wheels
    4
  end
  
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle; end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload
  
  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
  
  def wheels
    6
  end
end

car = Car.new("Mitsubishi", "Lancer")
truck = Truck.new("Ford", "F-350", "3000")
moto = Motorcycle.new("Kawasaki", "Ninja")

puts "Car:"
puts car, car.wheels
puts
puts "Truck:"
puts truck, truck.wheels, truck.make
puts
puts "Motorcycle:"
puts moto, moto.wheels

=begin

Further Exploration

Would it make sense to define a wheels method in Vehicle even though all of the remaining classes would be overriding it? Why or why not? If you think it does make sense, what method body would you write?

Yes, I decided to put wheels in the vehicle class because most vehicles are going to have wheels. As most vehicles will probably have 4, I put 4 in the body.

=end