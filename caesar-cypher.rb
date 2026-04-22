
def cypher (string, shift = 1)

  string.chars.map do |letter|
  if letter =~ /[a-zA-Z]/
    (letter.ord + shift).chr
  else
    letter
  end
  
end.join
  
end

puts cypher("Whats Up!", 3)

# = Zkdwv Xs!
# 
# 
#
#
#