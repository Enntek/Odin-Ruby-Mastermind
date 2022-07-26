# Odin Ruby Project: Mastermind
# https://www.theodinproject.com/lessons/ruby-mastermind
# Goal: Build a console based version of the game Mastermind
# My settings: 6 numbers, 10 guesses


# the <super> in the baseclass Class Method refers to the Superclass's Class Method too.

# how can we use inheritance?

class BoardGame
  def self.description
    puts "This is a game that's fun for the whole family!"
  end
end

class Mastermind < BoardGame
  @@name = "Mastermind"

  def initialize
    @human = Human.new
    @computer = Computer.new
    @human.speak

    puts "\t  X X X X "
    10.times do
      puts "\t|---------|"
      puts "\t| * * * * |"
    end

    # draw_board
  end

  def draw_board
    puts "\t  X X X X "
    9.times do # this depends on turn no.
      puts "\t|---------|"
      puts "\t| * * * * |"
    end
    # puts "\t|---------|"
    # puts "\t| 1 2 6 3 |"
  end
  
  def self.description
    super
    puts "Mastermind is a 2 player game. \nOne is the codesetter, and the other the codebreaker."
  end
  
  def self.history
    "This game dates back a century when it was then called Bulls & Cows."
  end
end

class Player
  def description
    puts "A game will have x number of players"
  end

  def take_turn
  end
end

class Human < Player
  def initialize
  end

  def speak
    puts "I am made of flesh and blood!"
  end
end

class Computer < Player
  def initialize
  end

  def speak
    puts "I am made of 1s and 0s."
  end
end

# BoardGame.description
Mastermind.description
new_game = Mastermind.new


# Mastermind project:
# numbers 1 - 6
# randomize
# human guesses first
# 1111
# 1 number is in the place
# 1222
# 1 red, 1 white
# 1233
# 1 red, 2 white
# 1234
# 1 red, 3 white