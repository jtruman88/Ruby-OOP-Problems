=begin

Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
You win!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low
You are out of guesses. You lose.

Note that a game object should start a new game with a new number to guess with each call to #play.

=end

module Displayable
  def display_welcome
    puts "Welcome to the number guessing game!"
    puts "You will have 7 chances to guess a"
    puts "number between 1 and 100. good luck!"
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
  attr_accessor :number, :guesses, :correct

  include Displayable

  def play
    display_welcome
    setup_game
    loop do
      display_guesses_left
      get_guess
      decrement_guesses
      if out_of_guesses?
        display_loss
        break
      elsif correct
        break
      end
    end
  end

  private

  def setup_game
    self.number = rand(1..100)
    self.guesses = 7
    self.correct = false
  end

  def get_guess
    guess = 0
    loop do
      print "Enter a number between 1 and 100: "
      guess = gets.chomp.to_i
      break if (1..100).include?(guess)
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

game = GuessingGame.new
game.play
game.play
