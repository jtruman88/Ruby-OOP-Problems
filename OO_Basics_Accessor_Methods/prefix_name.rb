# Using the following code, add the appropriate accessor methods so that @name is returned with the added prefix 'Mr.'.

=begin
class Person
end

person1 = Person.new
person1.name = 'James'
puts person1.name
=end

class Person
  attr_writer :name
  
  def name
    "Mr. #{@name}"
  end
end

person = Person.new
person.name = 'James'
puts person.name