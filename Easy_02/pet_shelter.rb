=begin

Consider the following code:

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
Write the classes and methods that will be necessary to make this code run, and print the following output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The order of the output does not matter, so long as all of the information is presented.

=end

class Shelter
  attr_accessor :adoptions, :unadopted, :owners

  def initialize
    @adoptions = {}
    @unadopted = []
    @owners = []
  end

  def intake(type, name)
    self.unadopted << Pet.new(type, name)
  end

  def register_owner(first_name, last_name)
    self.owners << Owner.new(first_name, last_name)
  end

  def adopt
    owner = find_owner
    pet = find_pet
    owner.pets << pet
    adoptions[owner] = owner.pets
    puts "#{owner} has adopted #{pet}."
    set_adopted(pet)
  end

  def set_adopted(pet)
    self.unadopted = unadopted.reject { |animal| animal == pet }
  end

  def find_pet
    name = ''
    loop do
      puts "Enter pet name:"
      name = gets.chomp.capitalize
      break if available?(name)
      puts "Sorry, pet not found."
    end
    match = nil
    unadopted.each do |pet|
      match = pet if name == pet.name
    end
    match
  end

  def available?(name)
    unadopted.each do |pet|
      return true if name == pet.name
    end
    false
  end

  def find_owner
    name = ''
    loop do
      puts "Enter Owner's last name:"
      name = gets.chomp.capitalize
      break if registered?(name)
      puts "Sorry, name not found."
    end
    match = nil
    owners.each do |owner|
      match = owner if name == owner.last_name
    end
    match
  end

  def registered?(name)
    owners.each do |owner|
      return true if name == owner.last_name
    end
    false
  end

  def print_adoptions
    adoptions.each do |owner, pets|
      puts "#{owner} has adopted the following pets:"
      pets.each do |pet|
        puts pet
      end
      puts
    end
  end

  def print_unadopted
    puts "The following pets are still available for adoption:"
    unadopted.each do |pet|
      puts pet
    end
    puts
  end

  def print_adoptions_count
    adoptions.each do |owner, pets|
      puts "#{owner} has adopted #{pets.length} pets."
    end
  end
end

class Owner
  attr_reader :first_name, :last_name
  attr_accessor :pets

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @pets = []
  end

  def number_of_pets
    pets.length
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

shelter = Shelter.new

shelter.intake('cat', 'Butterscotch')
shelter.intake('cat', 'Pudding')
shelter.intake('bearded dragon', 'Darwin')
shelter.intake('dog', 'Kennedy')
shelter.intake('parakeet', 'Sweetie Pie')
shelter.intake('dog', 'Molly')
shelter.intake('fish', 'Chester')
shelter.intake('dog', 'Asta')
shelter.intake('dog', 'Laddie')
shelter.intake('cat', 'Fluffy')
shelter.intake('cat', 'Kat')
shelter.intake('cat', 'Ben')
shelter.intake('parakeet', 'Chatterbox')
shelter.intake('parakeet', 'Bluebell')

shelter.register_owner('Pete', 'Hanson')
shelter.register_owner('Betty', 'Holmes')

shelter.adopt
shelter.adopt
shelter.adopt
shelter.adopt
shelter.adopt
shelter.print_adoptions
shelter.print_unadopted
shelter.print_adoptions_count


=begin

Further Exploration -

Suppose the shelter has a number of not-yet-adopted pets, and wants to manage them through this same system. Thus, you should be able to add the following output to the example output shown above:

The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell
   ...

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The Animal shelter has 7 unadopted pets.
Can you make these updates to your solution? Did you need to change your class system at all? Were you able to make all of your changes without modifying the existing interface?

=end
