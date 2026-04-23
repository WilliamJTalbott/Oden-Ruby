def stock_picker (array)

  diffs = array[0..-2].map.with_index() { |value, index| array[(index+1)..].max - value}
  buy = diffs.index(diffs.max)
  sell = array.index(array[(buy+1)..].max)
  return [buy, sell]
end

puts stock_picker([10000,45,163,12,114,15,161,134,153,34,13,134,174,1,124,1,3,145,65,6,0])

# > stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]  # for a profit of $15 - $3 == $12