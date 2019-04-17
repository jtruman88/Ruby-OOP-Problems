=begin

Below we have 3 classes: Student, Graduate, and Undergraduate. Some details for these classes are missing. Make changes to the classes below so that the following requirements are fulfilled:

Graduate students have the option to use on-campus parking, while Undergraduate students do not.

Graduate and Undergraduate students have a name and year associated with them.

Note: you can do this by adding or altering no more than 5 lines of code.

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate
  def initialize(name, year, parking)
  end
end

class Undergraduate
  def initialize(name, year)
  end
end

=end

class Student
  attr_accessor :name, :year
  
  def initialize(name, year)
    @name = name
    @year = year
  end
  
  def parking
    "off campus"
  end
  
  def to_s
    "#{name} is a #{year} student that can park #{parking}"
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
  
  def parking
    "#{super} or in lot #{@parking}."
  end
end

class Undergraduate < Student
end

student = Undergraduate.new("Jaron", 2017)
puts student

student1 = Graduate.new("Mesa", 2013, 'B')
puts student1