# Add the appropriate accessor methods to the following code.

=begin
class Person
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name
=end

class Person
  attr_reader :name
  attr_writer :name
end

person = Person.new
person.name = "Jessica"
puts person.name