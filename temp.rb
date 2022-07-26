class BoardGame
  def initialize(note_to_self)
    @note_to_self = note_to_self
    puts "BoardGame has been instantiated."

    puts @note_to_self
  end

  def display_message
    puts "I'm a boardgame!"
  end
end

class Mastermind < BoardGame

  def initialize(version, note)
    super(note)
    @version = version
  end

  def display_message
    super
    puts "Mastermind is great fun!"
  end
end

newgame = Mastermind.new("1.4", "buy another game")
newgame.display_message


# 10.step(0, -1) do |i|
#   puts i 
# end

# for i in (0..10).reverse_each
#   puts i 
# end

str = "|0123456789|"
# add text to str

s1= str[0..5]
s2= str[6..-1]

# new_str = str[5..-1]

# new_str = s1 + "hello" + s2

# puts new_str

digit_bank = [1, 2, 3, 4, 5, 6]
code_arr = []
4.times do 
  rand_digit = digit_bank.sample
  code_arr.push(rand_digit)
  digit_bank.delete(rand_digit)
end
p code_arr
p digit_bank