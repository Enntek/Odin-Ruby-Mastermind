require 'pry-byebug'

class String
  def insert_overwrite(str, index)
    self.insert(index, str)
    self[0..(index + str.length - 1)] + self[(index + str.length + str.length)..-1]
  end
end



p "hey, hello world!".insert_overwrite("heywhatisthisthing", 5)

#=> 'hey, wazza world!'