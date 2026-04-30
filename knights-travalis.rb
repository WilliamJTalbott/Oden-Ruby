#require 'set'
#Use Sets later if revisiting. 

class Knight

  def initialize(start, target)

    @start_queue = [start]
    @target_queue = [target]

    @from_start = { start => nil }
    @from_target = { target => nil }
  end

  def get_path()
    until @start_queue.empty? or @target_queue.empty?
      return result if (result = search(@start_queue, @from_start, @from_target))
      return result if (result = search(@target_queue, @from_target, @from_start))
    end
  end

  def get_moves(pos)
    moves = []

    [2, -2].each do |long|
      [1, -1].each do |short|
        moves << [pos[0] + long, pos[1] + short]
        moves << [pos[0] + short, pos[1] + long]
      end
    end

    moves.select { |x, y| x.between?(0, 7) and y.between?(0, 7) }
  end

  def search(queue, this_side, other_side)

    next_queue = []

    queue.each do |pos|
      get_moves(pos).each do |move|

        next if this_side.key?(move)
        this_side[move] = pos

        if other_side.key?(move)
          return assemble_path(move)
        else
          next_queue << move
        end



      end
    end

    queue.replace(next_queue)
    nil

  end

  def walk_path(from_hash, move)
    path = []
    until move.nil?
      path << move
      move = from_hash[move]
    end
    path
  end

  def assemble_path(move)
    start_path = walk_path(@from_start, move).reverse()
    end_path = walk_path(@from_target, move)

    start_path + end_path[1..]
  end

end

knight = Knight.new([7,7],[0,0])
print(knight.get_path())