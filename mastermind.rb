# Odin Ruby Project: Mastermind
# https://www.theodinproject.com/lessons/ruby-mastermind
# Goal: Build a console based version of the game Mastermind
# My settings: 6 numbers, 10 guesses

# readability, modularity, brevity

# the <super> in the baseclass Class Method refers to the Superclass's Class Method too.
# how can we use inheritance?

class BoardGame
  def self.description
    puts "\n<< This is a game that's fun for the whole family! >>\n "
  end
end

class Mastermind < BoardGame
  @@name = "Mastermind"
  attr_reader :current_turn

  def initialize
    @secret_code = []
    @current_turn = "\t Current turn | * * * * |" 
    human = Human.new
    computer = Computer.new
    establish_secret_code(computer.code)
    human.speak
    draw_board
    play_game(human, computer)
  end

  def play_game(player1, player2)
    player1.take_turn
    compare_codes(player1)
    # player2.take_turn
  end

  def establish_secret_code(code)
    @secret_code = code.split("")
    puts "Secret code established!!"
  end

  def draw_board
    # use Array.new to save each turn
    # after each sucessive turn, set array[index] to turn
    # draw board with elements from this array

    puts "\n\t                X X X X "
    9.times do # this depends on turn no.
      puts "\t              |---------|"
      puts "\t              | * * * * |"
    end
    puts "\t              |---------|"
    puts current_turn
    puts "\n"
  end

  def compare_codes(player)
    num_of_red_pegs = 0
    num_of_white_pegs = 0

    if player.guess == @secret_code then puts "You guessed correctly!!!" end
    
    num_of_red_pegs = @secret_code.each_index.reduce(0) do |total_red, index|
      if player.guess[index] == @secret_code[index]
        total_red +=1
      end

      total_red
    end
    
    wrong_code_digits = @secret_code - player.guess #subtract 2 arrays
    num_correct_digits = 4 - wrong_code_digits.length
    num_of_white_pegs = num_correct_digits - num_of_red_pegs
    
    # p "num_of_red_pegs: #{num_of_red_pegs}"
    # p "num_of_white_pegs: #{num_of_white_pegs}"
  end
  
  def self.description
    super
    puts "<<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>><<>>"
    puts "<< Mastermind is a classic 2 player boardgame. >> \n\n<< One player is the code-setter, and the other the codebreaker. >>\n "
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
    @guess = @guess.split("")
  end
end

class Computer < Player
  attr_reader :code

  def initialize
    set_code
  end

  def set_code
    @code = "1234" # randomize later
  end

  def speak
    puts "I am made of 1s and 0s."
  end
end

# BoardGame.description (subclass inherits)
Mastermind.description
new_game = Mastermind.new