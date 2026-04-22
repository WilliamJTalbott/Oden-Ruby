def substrings( words , dictionary )

  words = words.split()

  results = Hash.new(0)

  words.each do |word|
    dictionary.each() do |value|
      count = word.scan(value).length
      unless count == 0
        results[value] += count
      end
    end
  end


  return results
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings( "howdy how where are you going i will", dictionary)

# (x, y)
#How many y are in x