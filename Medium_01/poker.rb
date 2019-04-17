=begin

In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.

You should build your class using the following code skeleton:

# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(deck)
  end

  def print
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
  end

  def straight_flush?
  end

  def four_of_a_kind?
  end

  def full_house?
  end

  def flush?
  end

  def straight?
  end

  def three_of_a_kind?
  end

  def two_pair?
  end

  def pair?
  end
end

Testing your class:

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

Output:

5 of Clubs
7 of Diamonds
Ace of Hearts
7 of Clubs
5 of Spades
Two pair
true
true
true
true
true
true
true
true
true
true
true
true

The exact cards and the type of hand will vary with each run.

=end

class Card
  include Comparable

  attr_reader :rank, :suit

  VALUES = {
    2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7,
    8 => 8, 9 => 9, 10 => 10, 'Jack' => 11, 'Queen' => 12,
    'King' => 13, 'Ace' => 14
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES[self.rank]
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  attr_accessor :deck

  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = new_deck
  end

  def draw
    self.deck = new_deck if self.deck.empty?
    self.deck.pop
  end

  def to_s
    deck.join(', ')
  end

  private

  def new_deck
    cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end

    cards.shuffle
  end
end

class PokerHand
  attr_accessor :hand, :deck

  def initialize(deck)
    @deck = deck
    @hand = draw_five
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def draw_five
    cards = []
    5.times { cards << deck.draw }
    cards
  end

  def royal_flush?
    # if the five cards are 10, j, q, k, a and all have the same suit
    royals = [10, 'Jack', 'Queen', 'King', 'Ace']
    all_same_suit? &&
    hand.all? do |card|
      royals.include?(card.rank)
    end
  end

  def straight_flush?
    # if all five cards are in sequance by rank and all have the same suit
    all_in_sequence? && all_same_suit?
  end

  def four_of_a_kind?
    # if four of the cards have the same rank
    card_count = Hash.new(0)
    hand.each do |card|
      card_count[card.rank] += 1
    end

    card_count.values.count(4) == 1
  end

  def full_house?
    # if two of the cards have the same rank, and the other three have the same rank
    card_count = Hash.new(0)
    hand.each do |card|
      card_count[card.rank] += 1
    end

    card_count.values.count(2) == 1 &&
    card_count.values.count(3) == 1
  end

  def flush?
    # if the suits on all five cards are the same
    all_same_suit?
  end

  def straight?
    # if all five cards are in a sequence by rank
    all_in_sequence?
  end

  def three_of_a_kind?
    # if three of the cards have the same rank and the other two are different
    card_count = Hash.new(0)
    hand.each do |card|
      card_count[card.rank] += 1
    end

    card_count.values.count(3) == 1
  end

  def two_pair?
    # if two sets of two of the cards have the same rank, the fifth is different
    card_count = Hash.new(0)
    hand.each do |card|
      card_count[card.rank] += 1
    end

    card_count.values.count(2) == 2
  end

  def pair?
    # if two and only two cards have the same rank and the rest are different
    card_count = Hash.new(0)
    hand.each do |card|
      card_count[card.rank] += 1
    end

    card_count.values.count(2) == 1
  end

  def all_in_sequence?
    values = hand.map { |card| card.value }.sort

    temp = values.first
    ind = 1
    while ind < values.length
      return false unless temp + 1 == values[ind]
      temp = values[ind]
      ind += 1
    end

    true
  end

  def all_same_suit?
    card_count = Hash.new(0)
    hand.each do |card|
      card_count[card.suit] += 1
    end

    card_count.length == 1
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
      

=begin
Further Exploration

The following questions are meant to be thought exercises; rather than write code, think about what you would need to do. Feel free to write some code after thinking about the problem.

How would you modify this class if you wanted the individual classification methods (royal_flush?, straight?, three_of_a_kind?, etc) to be public class methods that work with an an Array of 5 cards, e.g.,

def self.royal_flush?(cards)
  ...
end
How would you modify our original solution to choose the best hand between two poker hands?

How would you modify our original solution to choose the best 5-card hand from a 7-card poker hand?

=end
