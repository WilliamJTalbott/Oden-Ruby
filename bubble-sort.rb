def bubble_sort(arr)
  
  arr.length.times do
    arr[..-2].each_with_index do |_, x|
      if arr[x] > arr[x+1]
        arr[x], arr[x+1] = arr[x+1], arr[x]
      end
    end
  end
  arr
end

puts bubble_sort([4,3,78,2,0,2])

# > bubble_sort([4,3,78,2,0,2])
# => [0,2,2,3,4,78]