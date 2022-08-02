# Odin Ruby Project: Mastermind
# https://www.theodinproject.com/lessons/ruby-mastermind
# Goal: Build a console based version of the game Mastermind
# My settings: 6 numbers, 10 guesses

# the <super> in the baseclass Class Method refers to the Superclass's Class Method too.

# symbols: 🢂🢀⏺

# add:
# find unicode symbol that works on replit, current peg doesn't show color
# check valid input for: select side, digit input
# work on computer play
# make some private/public methods to get used to making these
# try namespacing using modules
# include 1 module's method

# overwrite string with a substring, does not change length

# module Maths
#   class Addition
#     def sum(a, b)
#       a + b
#     end
#   end
# end

require 'pry-byebug'

module Playable
  puts 'This is a playable game!'
end

class BoardGame
  @@version = '1.00'
  def description
    puts 'Boardgames are a great way to spend time with family!'
  end

  def self.show_version
    puts @@version
  end
end

class Mastermind < BoardGame
  @@version = '0.95 Beta'
  

  def initialize
    intro
    choose_role
    set_secret_code
    @guesses = 0
    @game_won = false
    initialize_board
    draw_board
  end

  def choose_role
    puts "               Would you like to be the code-maker(M) or code-breaker(B)?"
    choice = gets.chomp

    if true == true
      @human = CodeBreaker.new
      @computer = CodeSetter.new 
    else
      @human = CodeSetter.new
      @computer = CodeBreaker.new
    end
  end

  def set_secret_code
    @secret_code = @computer.code.to_s.split('')
  end

  def initialize_board
    @code_bar = "┋ Turn ┋#{'   ?   '.bg_black}┋#{'   ?   '.bg_black}┋#{'   ?   '.bg_black}┋#{'   ?   '.bg_black}┋   Clues   ┋"
    @turns = Array.new(10) { Array.new(3) }
    @turns.reverse_each.with_index do |subarr, index|
      if index < 9
        subarr[0] = "┋  #{index + 1}  ┆"
      else
        subarr[0] = "┋  #{index + 1} ┆"
      end

      subarr[1] = "┋#{'       '.bg_gray}┋#{'       '.bg_gray}┋#{'       '.bg_gray}┋#{'       '.bg_gray}┋"
      subarr[2] = '┆ ⏺ ⏺ ⏺ ⏺  ┋'
    end
  end

  def draw_board
    puts ' __________________________________________________'
    puts '┋              ⏺⏺⏺⏺  MASTERMIND ⏺⏺⏺⏺               ┋'
    puts '┋==================================================┋'
    puts @code_bar
    puts '┋╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┋'
    @turns.each do |subarray|
      puts subarray[0] + subarray[1] + subarray[2]
      puts '┋--------------------------------------------------┋'
    end
    puts "'╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍'"
  end

  def play
    loop do
      take_turn
      check_guess
      draw_board

      if @guesses == 10 && @game_won == false
        puts "You are out of turns!\n"\
              "Game over!"
        return
      elsif @game_won == true
        win_message
        return
      end
    end

  end

  def win_message
    puts "You cracked the secret code!\n"\
        "Congratulations, you won!"
    
  end

  def take_turn
    get_guess
    @guesses += 1
  end

  # now, draw the bar

  def get_guess
    if @human.is_a?(CodeBreaker)
      puts 'Please enter a guess: '
      @guess = @human.input_guess.to_s.split('')
    end
  end

  def check_guess
    set_bar_colors(@guess)

    if @guess == @secret_code
      @game_won = true
      set_bar_colors(@secret_code)
    else
      red_pegs = calculate_red_pegs(@guess, @secret_code)
      brown_pegs = calculate_brown_pegs(@guess, @secret_code, red_pegs)
      build_pegs(red_pegs, brown_pegs)
    end
  end

  def set_bar_colors(array)
    color_bar = ''

    array.each do |num|
      case num
      when '1'
        color_bar += "#{'   1   '.bg_red}" + '┋'
      when '2'
        color_bar += "#{'   2   '.bg_green}" + '┋'
      when '3'
        color_bar += "#{'   3   '.bg_blue}" + '┋'
      when '4'
        color_bar += "#{'   4   '.bg_magenta}" + '┋'
      when '5'
        color_bar += "#{'   5   '.bg_cyan}" + '┋'
      when '6'
        color_bar += "#{'   6   '.bg_brown}" + '┋'
      end
    end

    if array == @secret_code
      @code_bar = '┋ Turn ┋' + color_bar + '           ┋'
    end

    if array == @guess
      @turns[10-@guesses][1] = '┋' + color_bar
    end
  end

  def build_pegs(num_reds, num_browns)
    pegs = ''

    num_reds.times do
      pegs += "#{'⏺ '.red}"
    end

    num_browns.times do
      pegs += "#{'⏺ '.brown}"
    end

    (4 - num_reds - num_browns).times do
      pegs += "#{'⏺ '.gray}"
    end

    @turns[10 - @guesses][2] = '┆ ' + pegs  + ' ┋'
  end

  def calculate_red_pegs(guess, code)
    code.each_index.reduce(0) do |total_red, index|
      if guess[index] == code[index]
        total_red +=1
      end

      total_red
    end
  end

  def calculate_brown_pegs(guess, code, num_reds)
    wrong_code_digits = code - guess #subtract 2 arrays
    num_correct_digits = 4 - wrong_code_digits.length
    num_of_brown_pegs = num_correct_digits - num_reds
  end

  def intro
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
    end
end

class CodeBreaker
  def initialize
  end

  def input_guess
    gets.chomp
  end
end

class CodeSetter
  attr_reader :code

  def initialize
    input_code
  end

  def input_code
    @code = 1234
  end
end

class String
  # Overwrite part of a string, do not change length of string
  def insert_overwrite(str, index)
    self.insert(index, str)
    self[0..(index + str.length - 1)] + self[(index + str.length + str.length)..-1]
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

# Mastermind.show_version
new = Mastermind.new
new.play

