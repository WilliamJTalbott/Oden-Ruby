
ORDER = ("a".."z").to_a()

def cypher (string, shift = 1)

  encoded = string.chars()

  encoded.each_with_index() do |value, index|

    original_index = ORDER.index(value.downcase)

    if original_index
      shifted_index = (original_index + shift)  % ORDER.length
      encoded[index] = ORDER[shifted_index]
      if value == value.upcase
        encoded[index] = encoded[index].upcase
      end
    else
      encoded[index] = value
    end
  end

  
  
  return encoded.join()
  
end

puts cypher("Whats Up!", 3)

# = Zkdwv Xs!
# 
# 
#
#
#