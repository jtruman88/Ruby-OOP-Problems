=begin

In the previous exercise, you wrote a number guessing game that determines a secret number between 1 and 100, and gives the user 7 opportunities to guess the number.

Update your solution to accept a low and high value when you create a GuessingGame object, and use those values to compute a secret number for the game. You should also change the number of guesses allowed so the user can always win if she uses a good strategy. You can compute the number of guesses with:

Math.log2(size_of_range).to_i + 1
Examples:

game = GuessingGame.new(501, 1500)
game.play

You have 10 guesses remaining.
Enter a number between 501 and 1500: 104
Invalid guess. Enter a number between 501 and 1500: 1000
Your guess is too low

You have 9 guesses remaining.
Enter a number between 501 and 1500: 1250
Your guess is too low

You have 8 guesses remaining.
Enter a number between 501 and 1500: 1375
Your guess is too high

You have 7 guesses remaining.
Enter a number between 501 and 1500: 80
Invalid guess. Enter a number between 501 and 1500: 1312
Your guess is too low

You have 6 guesses remaining.
Enter a number between 501 and 1500: 1343
Your guess is too low

You have 5 guesses remaining.
Enter a number between 501 and 1500: 1359
Your guess is too high

You have 4 guesses remaining.
Enter a number between 501 and 1500: 1351
Your guess is too high

You have 3 guesses remaining.
Enter a number between 501 and 1500: 1355
You win!

game.play
You have 10 guesses remaining.
Enter a number between 501 and 1500: 1000
Your guess is too high

You have 9 guesses remaining.
Enter a number between 501 and 1500: 750
Your guess is too low

You have 8 guesses remaining.
Enter a number between 501 and 1500: 875
Your guess is too high

You have 7 guesses remaining.
Enter a number between 501 and 1500: 812
Your guess is too low

You have 6 guesses remaining.
Enter a number between 501 and 1500: 843
Your guess is too high

You have 5 guesses remaining.
Enter a number between 501 and 1500: 820
Your guess is too low

You have 4 guesses remaining.
Enter a number between 501 and 1500: 830
Your guess is too low

You have 3 guesses remaining.
Enter a number between 501 and 1500: 835
Your guess is too low

You have 2 guesses remaining.
Enter a number between 501 and 1500: 836
Your guess is too low

You have 1 guesses remaining.
Enter a number between 501 and 1500: 837
Your guess is too low

You are out of guesses. You lose.

Note that a game object should start a new game with a new number to guess with each call to #play.

=end

module Displayable
  def display_welcome
    puts "Welcome to the number guessing game!"
    puts "You will have #{guesses} chances to guess a"
    puts "number between #{min_num} and #{max_num}. good luck!"
  end
  
  def display_guesses_left
    if guesses == 1
      puts "You have #{guesses} guess left."
    else
      puts "You have #{guesses} guesses left."
    end
  end
  
  def display_result(guess)
    if guess > number
      puts "Your guess is too high."
    elsif guess < number
      puts "Your guess is too low."
    else
      puts "That's correct, you win!"
      self.correct = true
    end
  end
  
  def display_loss
    puts "You are out of guesses. You lose."
  end
end

class GuessingGame
  attr_accessor :number, :min_num, :max_num, :range, :guesses, :correct
  
  include Displayable
  
  def play
    setup_game
    display_welcome
    loop do
      display_guesses_left
      get_guess
      decrement_guesses
      if correct
        break
      elsif out_of_guesses?
        display_loss
        break
      end
    end
  end
  
  private
  
  def setup_game
    self.min_num, self.max_num, self.range = get_numbers
    self.number = rand(min_num..max_num)
    self.guesses = Math.log2(range).to_i + 1
    self.correct = false
  end
  
  def get_numbers
    min = rand(1..500)
    range = rand(600..1000)
    max = min + range
    [min, max, range]
  end
  
  def get_guess
    guess = 0
    loop do
      print "Enter a number between 1 and 100: "
      guess = gets.chomp.to_i
      break if (min_num..max_num).include?(guess)
      print "Invalid input. "
    end
    display_result(guess)
  end
  
  def out_of_guesses?
    guesses == 0
  end
    
  def decrement_guesses
    self.guesses -= 1
  end
end

GuessingGame.new.play

=begin
LSS

class GuessingGame
  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize(low, high)
    @range = low..high
    @max_guesses = Math.log2(high - low + 1).to_i + 1
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(@range)
  end

  def play_game
    result = nil
    @max_guesses.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      guess = gets.chomp.to_i
      return guess if @range.cover?(guess)
      print "Invalid guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

=end