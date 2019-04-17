# Modify the following code to accept a string containing a first and last name. The name should be split into two instance variables in the setter method, then joined in the getter method to form a full name.

=begin
class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
=end

class Person
  def name=(n)
    names = n.split
    @first_name = names.first
    @last_name = names.last
    # @first_name, @last_name = name.split(' ')
  end
  
  def name
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new
person.name = "John Smith"
puts person.name