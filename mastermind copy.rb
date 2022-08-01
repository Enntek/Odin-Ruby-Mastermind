# Odin Ruby Project: Mastermind
# https://www.theodinproject.com/lessons/ruby-mastermind
# Goal: Build a console based version of the game Mastermind
# My settings: 6 numbers, 10 guesses

# the <super> in the baseclass Class Method refers to the Superclass's Class Method too.

# symbols: 🢂🢀⏺

# add:
# work on computer play
# make some private/public methods to get used to making these
# try namespacing using modules
# include 1 module's method

# overwrite string with a substring, does not change length

require 'pry-byebug'

class String
  # Overwrite part of a string, do not change length of string
  def insert_overwrite(str, index)
    self.insert(index, str)
    self[0..(index + str.length - 1)] + self[(index + str.length + str.length)..-1]
  end
end

module Versionable

  # In order to modularize class methods, do it this way
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def show_version
      puts @@version
    end
  end
end

class BoardGame
  def self.description
    puts "\n<< This is a game that's fun for the whole family! >>\n "
  end
end

class Mastermind < BoardGame
  include Versionable

  @@name = 'Mastermind'
  @@version = '0.95 Beta'
  attr_reader :current_turn

  def initialize
    @secret_code = []
    @turn_number = 1
    @game_over = false
    human = Human.new
    computer = Computer.new
    establish_secret_code(computer.code)
    # human.speak
    # @current_turn = "                        Current turn | * * * * |"
    # @all_turns = Array.new(10, "                                     | * * * * |")
    # @all_turns[0] = @current_turn
    draw_board
    play_game(human, computer)
  end

  def play_game(player1, player2)
    loop do
      player1.take_turn
      compare_codes(player1)
      draw_board
      break if @game_over == true
    end
  end

  def establish_secret_code(code)
    @secret_code = code
    puts "\n"\
        "                              Secret code established!!\n"
  end

  def draw_board
    if @game_over == true
      puts "\n                #{@secret_code[0]} #{@secret_code[1]} #{@secret_code[2]} #{@secret_code[3]} "
    else
      puts "\n                                       X X X X "
    end

    for i in (0..@all_turns.length-1).reverse_each
      # puts "                                     |---------|"
      # puts @all_turns[i]
    end

    puts "\n"
  end

  def compare_codes(player)
    num_of_red_pegs = 0
    num_of_white_pegs = 0

    if player.guess == @secret_code
      puts "\n\t<< You cracked the code! You won! >>\n"
      @game_over = true
    end

    num_of_red_pegs = @secret_code.each_index.reduce(0) do |total_red, index|
      if player.guess[index] == @secret_code[index]
        total_red +=1
      end

      total_red
    end

    wrong_code_digits = @secret_code - player.guess #subtract 2 arrays
    num_correct_digits = 4 - wrong_code_digits.length
    num_of_white_pegs = num_correct_digits - num_of_red_pegs

    pegs = ''
    num_of_red_pegs.times { pegs += "⏺  ".red }
    num_of_white_pegs.times { pegs += "⏺  ".gray }

    if @turn_number <= 10  then
      @turn_number += 1
    end

    @all_turns[@turn_number-2] = "                                     | #{player.guess[0]} #{player.guess[1]} #{player.guess[2]} #{player.guess[3]} | #{pegs}" 

    # insert 'Current turn'
    if @turn_number <= 10 then
      if @game_over == true 
        @all_turns[@turn_number - 1] =  "              | * * * * | You won!"
      else
        @all_turns[@turn_number - 1] = @current_turn
      end
    end

    # insert 'Game over' after last turn
    if @turn_number == 11 then
      # change string on last turn
      s1 = @all_turns[@turn_number-2][0..2]
      s2 = @all_turns[@turn_number-2][12..-1]
      @all_turns[@turn_number-2] = s1 + 'Game Over' + s2
    end

  end

  def self.description
    super
    puts "\n"\
          "                     ⏺ ⏺ ⏺ ⏺    #{'Welcome to Mastermind!'.red}   ⏺ ⏺ ⏺ ⏺       \n"\
          " \n"\
          "              Mastermind is a classic code-breaking game with 2 players. \n"\
          "             One player is the code-maker, the other is the code-breaker. \n"\
          " \n"\
          "           You will choose to be either the code-maker or the code-breaker. \n"\
          "         The code-maker will establish a hard to guess code. It is the job of \n"\
          "                   the code-breaker to crack the code within 10 tries.\n"\
          " \n"\
          "            After each attempt, the code-breaker will be given these clues:\n"\
          "              #{"⏺".red} - Indication that the color and the location is CORRECT.\n"\
          "         #{"⏺".gray} - Indication that the color is correct and the location is INCORRECT.\n"\
          " \n"\
          "Please enter \'1\' if would like to be the code breaker of \'2\' if you would like to be the\n"\
          'code maker'
  end

  def self.history
    'This game dates back a century when it was then called Bulls & Cows.'
  end
end

class Player
  def description
    puts 'A player is a participant of a game.'
  end

  def take_turn
    puts '                  Enter 4 digits (1 to 6) and check your guess:'
  end
end

class Human < Player
  attr :guess

  def initialize
  end

  def speak
    puts 'I am made of flesh and blood!'
  end

  def take_turn
    super
    @guess = gets.chomp
    @guess = @guess.split('')
  end
end

class Computer < Player
  attr_reader :code

  def initialize
    set_code
  end

  def set_code
    digit_bank = ['1', '2', '3', '4', '5', '6']
    code_arr = []

    4.times do 
      rand_digit = digit_bank.sample
      code_arr.push(rand_digit)
      digit_bank.delete(rand_digit)
    end

    @code = code_arr
    @code = ['1', '2', '3', '4'] # temp code
  end

  def speak
    puts 'I am made of 1s and 0s.'
  end
end

class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end
  def default;        "\e[39m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

# BoardGame.description (subclass inherits)
# Mastermind.description
# new_game = Mastermind.new
# Mastermind.show_version