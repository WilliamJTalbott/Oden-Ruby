# MasterMind
# create an array of 4 random values between 0-5
# human_input = [ ?,?,?,? ]
# Compare human_input with the code. 
# Return how many correct guesses and how many near correct guesses
# Attempts--

SYMBOLS = ["🟨", "🟧", "🟥", "🟪", "🟦", "⬛️"]

class Game

  def play_game(attempts, is_player_coder)

    com = ComputerPlayer.new
    hum = HumanPlayer.new

    coder = is_player_coder ? hum : com
    solver = is_player_coder ? com : hum

    board = Board.new

    code = coder.create_code()

    until attempts == 0
      attempts -= 1

      crack = solver.crack_code(board)

      if crack == code 
        return "YOU BROKE THE CODE!"
      else
        clues = get_clues(crack, code)
        board.append_to_current_row(clues)
        board.next_row()
      end
    end

    puts "GAME OVER"

  end

  def get_clues(crack, code)
    
    score = Array.new(3, 0)

    code.each_with_index do |value, index|
      if (crack[index] == value)
        score[0] += 1
      elsif (crack.any?() {|v| value == v})
        score[1] += 1
      else
        score[2] += 1
      end
    end

    "✅" * score[0] + "🟩" * score[1] + "⬜️" * score[2]
  end

end


class Board
  attr_reader(:row, :board)

  def initialize
    @board = []
    @row = 0
  end

  def next_row()
    @row += 1
  end

  def set_row(value)
    @board[@row] = value
    draw()
  end

  def append_to_current_row(text)
  @board[@row] += "   #{text}"
  draw
  end

  def draw()
    system("clear")

    @board.each do |row|
      puts row
    end

    puts "MASTERMIND 1🟨 2🟧 3🟥 4🟪 5🟦 6⬛"
  end
end

class Player

  def create_code
    return [0,0,0,0]
  end

  def crack_code(board)
    return [0,0,0,0]
  end
  
end

class HumanPlayer < Player
  def create_code
    code = []
    puts "Create your secret code (4 numbers 1-6)"

    4.times do
      input = nil
      until (1..6).include?(input)
        input = gets.chomp.to_i
      end

      code << input - 1
    end

    system("clear")
    code
  end

  def crack_code(board)

    values = []
    row = ""

    4.times do
      input = nil

      board.set_row(row)
      puts "Choose colors. (1-6)"

      until (1..6).include?(input)
        input = gets.chomp.to_i
      end

      values << input - 1
      row << SYMBOLS[input - 1]
    end

    values
  end
  
end

class ComputerPlayer < Player

  def initialize
    @previous_guesses = []
  end

  def create_code
    Array.new(4) { rand(0..5) }
  end

  def crack_code(board)
    guess = nil

    loop do
      guess = Array.new(4) { rand(0..5) }
      break unless @previous_guesses.include?(guess)
    end

    @previous_guesses << guess

    row = guess.map { |value| SYMBOLS[value] }.join

    board.set_row(row)

    guess
  end
  
end

game = Game.new()
game.play_game(10, true)