# Odin Ruby Project: Mastermind
# https://www.theodinproject.com/lessons/ruby-mastermind
# Goal: Build a console based version of the game Mastermind
# My settings: 6 numbers, 10 guesses

# readability, modularity, brevity
# the <super> in the baseclass Class Method refers to the Superclass's Class Method too.


# add:
# reveal code when player wins
# work on computer play
# remove "Current turn" after win
# move "you win" message below game_board
# make some private/public methods to get used to making these

class String
  def insert_overwrite(str, index)
    # given str and index
    # "overwrite" existing string at index
    # new string should be same length as old string. 
    # use .length to overwrite the same num of chars
    # we may reuse this one
  end

end


module Thing
  # think of a module to practice with
end

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
    @turn_number = 1
    human = Human.new
    computer = Computer.new
    establish_secret_code(computer.code)
    human.speak
    @current_turn = "\t Current turn | * * * * |" 
    @all_turns = Array.new(10, "\t              | * * * * |")
    @all_turns[0] = @current_turn
    draw_board
    play_game(human, computer)
  end

  def play_game(player1, player2)
    while true
      player1.take_turn
      compare_codes(player1)
      draw_board
    end
  end

  def establish_secret_code(code)
    @secret_code = code
    puts "Secret code established!!"
  end

  def draw_board
    puts "\n\t                X X X X "
    
    for i in (0..@all_turns.length-1).reverse_each
      puts "\t              |---------|"
      puts @all_turns[i]
    end

    puts "\n"
  end

  def compare_codes(player)
    num_of_red_pegs = 0
    num_of_white_pegs = 0

    if player.guess == @secret_code then puts "\n<< You cracked the code! You won! >>\n" end
    
    num_of_red_pegs = @secret_code.each_index.reduce(0) do |total_red, index|
      if player.guess[index] == @secret_code[index]
        total_red +=1
      end

      total_red
    end
    
    wrong_code_digits = @secret_code - player.guess #subtract 2 arrays
    num_correct_digits = 4 - wrong_code_digits.length
    num_of_white_pegs = num_correct_digits - num_of_red_pegs
    
    pegs = ""
    num_of_red_pegs.times { pegs += "R " }
    num_of_white_pegs.times { pegs += "W " }

    if @turn_number <= 10  then
      @turn_number += 1
    end

    @all_turns[@turn_number-2] = "\t              | #{player.guess[0]} #{player.guess[1]} #{player.guess[2]} #{player.guess[3]} | #{pegs}" 
    
    # insert "Current turn"
    if @turn_number <= 10 then
      @all_turns[@turn_number-1] = @current_turn
    end

    # insert "Game over" after last turn
    if @turn_number == 11 then
      # change string on last turn
      s1 = @all_turns[@turn_number-2][0..2]
      s2 = @all_turns[@turn_number-2][12..-1]
      @all_turns[@turn_number-2] = s1 + "Game Over" + s2
    end

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
    digit_bank = ["1", "2", "3", "4", "5", "6"]
    code_arr = []

    4.times do 
      rand_digit = digit_bank.sample
      code_arr.push(rand_digit)
      digit_bank.delete(rand_digit)
    end

    @code = code_arr
    # @code = "1234"
  end

  def speak
    puts "I am made of 1s and 0s."
  end
end

# BoardGame.description (subclass inherits)
Mastermind.description
new_game = Mastermind.new