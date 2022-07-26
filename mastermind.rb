# Odin Ruby Project: Mastermind
# https://www.theodinproject.com/lessons/ruby-mastermind
# Goal: Build a console based version of the game Mastermind
# My settings: 6 numbers, 10 guesses

# readability, modularity, brevity

# the <super> in the baseclass Class Method refers to the Superclass's Class Method too.

# how can we use inheritance?
# 

class BoardGame
  def self.description
    puts "\n<< This is a game that's fun for the whole family! >>\n "
  end
end

class Mastermind < BoardGame
  @@name = "Mastermind"

  def initialize
    human = Human.new
    computer = Computer.new
    establish_secret_code(computer.code)
    human.speak

    puts "\t  X X X X "
    10.times do
      puts "\t|---------|"
      puts "\t| * * * * |"
    end

    game(human, computer)
  end

  def game(player1, player2)
    player1.take_turn
    check_turn(player1)
    # player2.take_turn
  end

  def establish_secret_code(code)
    @secret_code = code
    puts "Secret code established!!"
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

  def check_turn(player)
    puts player.guess
  end
  
  def self.description
    super
    puts "<<>><<>><<>><<>><<>><<>><<>><<>><<>>"
    puts "<< Mastermind is a 2 player game. >> \n\n<< One player is the codesetter, and the other the codebreaker. >>\n "
    puts "<<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>>\n "
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
    puts "Enter 4 digits (1 to 6) and check your guess:"
  end
end

class Human < Player
  attr :guess

  def initialize
  end

  def speak
    puts "I am made of flesh and blood!"
  end

  def take_turn
    super
    @guess = gets.chomp
  end
end

class Computer < Player
  attr_reader :code

  def initialize
    set_code
  end

  def set_code
    @code = 1234 # randomize later
  end

  def speak
    puts "I am made of 1s and 0s."
  end
end

# BoardGame.description
Mastermind.description
new_game = Mastermind.new