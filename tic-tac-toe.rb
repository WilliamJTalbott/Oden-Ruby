
class Game

  def play_game()
    
    #Players
    human = HumanPlayer.new()
    computer = ComputerPlayer.new()
    player = human

    #Board
    board = Board.new()
    
    loop do
      if play_round(board, player)
        board.print_board
        return "#{player.title} wins!"
      else 
        player = player == human ? computer : human
      end
    end
    
  end

  def play_round(board, player)
    board.print_board
    board.mark(player.get_input(board.grid), player.token)
    return victory?(board.grid, player.token)
  end

  def victory?(grid, token)
    lines = []

    #Rows
    lines.concat(grid)

    #Columns
    lines << [grid[0][0],grid[1][0],grid[2][0]]
    lines << [grid[0][1],grid[1][1],grid[2][1]]
    lines << [grid[0][2],grid[1][2],grid[2][2]]
    
    #Diagonals
    lines << [grid[0][0], grid[1][1], grid[2][2]]
    lines << [grid[0][2], grid[1][1], grid[2][0]]
    
    lines.any? { |line| line.all? { |slot| slot == token}}
  end
  
end


class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end
  
  def mark(positon, token)
    row = positon / 3
    col = positon % 3

    @grid[row][col] = token
  end

  def print_board

    system("clear")

    @grid.each_with_index do |row, i|
      puts " #{row.join(' | ')} "
      puts "---+---+---" unless i == 2
    end
  end

end

class Player

  attr_reader :token, :title

  def initialize
    @title = "The Player"
    @token = "Token"
  end

  def get_input(grid)
    raise "Error. Call subclass"
  end
  
end

class HumanPlayer < Player
  def initialize
    @title = "The Human"
    @token = "X"
  end

  def get_input(grid)
    value = nil
    
    until (1..9).include?(value)
      print "Make your move! (enter 1-9)"
      value = gets.chomp.to_i
    end

    value - 1
  end

end

class ComputerPlayer < Player
  def initialize
    @title = "The Computer"
    @token = "O"
  end

  def get_input(board)
    empty_moves = []

    board.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        empty_moves << (r * 3 + c) if cell.nil?
      end
    end

    empty_moves.sample
  end
end

game = Game.new()
puts game.play_game()

# puts play_game(true)

#
#
#Play round
#Check for victory
#break or repeat
#
#Get user inpu