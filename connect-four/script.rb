class Game

  def play_game()
    setup()

    loop do
      @board.render()

      if @board.winner_from?(*play_turn(), @current_player.token)
        declare_winner()
        break
      end

      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end

  def setup()
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new

    @player1.create_profile("Player 1", "🔴")
    @player2.create_profile("Player 2", "🟡")

    @current_player = @player1
  end

  def play_turn()

    loop do
      
      action = @board.drop_piece(get_input(), @current_player.token)
      if action == -1
        print("Not a valid move")
      else
        return action
      end
    end
  end

  def declare_winner()
    puts("#{@current_player.name} wins!")
  end

  def get_input()
    puts "Pick a column (1-7)"
    loop do
      input = gets.chomp.downcase.strip.to_i
        if (1..7).include?(input)
          return input - 1
        end
      puts "Invalid input"
    end
  end

end

class Board
  attr_reader :grid

  def render
    system("clear")

    puts " 1 2 3 4 5 6 7"

    @grid.each do |row|
      puts row.map { |cell| cell == " " ? "⚪" : cell }.join(" ")
    end


    puts
  end

  def initialize
    @grid = Array.new(6) {Array.new(7, " ")}
  end

  def drop_piece(position, token)
    return -1 if @grid[0][position] != " "

    5.downto(0) do |row|
      if @grid[row][position] == " "
        @grid[row][position] = token
        return [row, position]
      end
    end

    -1
  end

  def winner_from?(row, column, token)
    directions = [
      [0, 1], # horizontal
      [1, 0], # vertical
      [1, 1], # diagonal down-right / up-left
      [1, -1] # diagonal down-left / up-right
    ]

    directions.any? do |row_change, column_change|
      count_direction(row, column, row_change, column_change, token) +
        count_direction(row, column, -row_change, -column_change, token) - 1 >= 4
    end
  end

  def count_direction(row, column, row_change, column_change, token)
    count = 0

    while in_bounds?(row, column) && @grid[row][column] == token
      count += 1
      row += row_change
      column += column_change
    end

    count
  end

  def in_bounds?(row, column)
    row.between?(0, 5) && column.between?(0, 6)
  end
end


class Player
  attr_reader :name, :token

  def create_profile(name, token)
    @name = name
    @token = token
  end

end
