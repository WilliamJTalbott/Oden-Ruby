def fibs_rec(number)

  puts ("recursion! #{number}")
  
  if number <= 1
    nil
  elsif number == 2
    [0, 1]
  else
    smaller = fibs_rec(number - 1)
    smaller << (smaller[-1] + smaller[-2])
  end

end

def merge_sort(array)

  if array.length <= 1
    return array
  else
    middle = array.length / 2
    front = merge_sort(array[0...middle])
    back = merge_sort(array[middle..-1])

    merge_loop(front, back)
    
  end

end

def merge_loop(front, back)
  result = []

  until front.empty? or back.empty?
    if front[0] <= back[0]
      result << front.shift
    else
      result << back.shift
    end
  end

  result + front + back
  
end

puts merge_sort([3, 2, 1, 13, 8, 5, 0, 1]) # -> [0, 1, 1, 2, 3, 5, 8, 13]

  #Main
  #
  #
  #
  #Smaller = Recursion
  #Apply change