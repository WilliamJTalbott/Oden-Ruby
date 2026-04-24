require 'json'

ROOT_DIR = __dir__
WORDS_FILE = File.join(ROOT_DIR, "words.txt")
SAVE_FILE = File.join(ROOT_DIR, "save.json")

HANGMAN = [
  # 0 wrong guesses
  """
  +---+
  |   |
      |
      |
      |
      |
=========
  """,

  # 1 wrong guess
  """
  +---+
  |   |
  O   |
      |
      |
      |
=========
  """,

  # 2 wrong guesses
  """
  +---+
  |   |
  O   |
  |   |
      |
      |
=========
  """,

  # 3 wrong guesses
  """
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========
  """,

  # 4 wrong guesses
  """
  +---+
  |   |
  O   |
 /|\\  |
      |
      |
=========
  """,

  # 5 wrong guesses
  """
  +---+
  |   |
  O   |
 /|\\  |
 /    |
      |
=========
  """,

  # 6 wrong guesses (lose)
  """
  +---+
  |   |
  O   |
 /|\\  |
 / \\  |
      |
=========
  """,

  # 7 win state
  """
  +---+
      |
 \\O/  |
  |   |
 / \\  |
      |
=========
  """
]

# _ r o g r a _ _ i n g
#Hangman
# User enters a letter "a"
# Get all the indexs of the value in the original string
# Add them to the display
# If at least 1 don't call draw_hangman()
# 
# When listening for input if player presses "1" to save the game
# When launching the game check if there is a save
# If so then ask if the player wants to use it
# If so then load it
# If not delete it and start a new game.

class Game

  def play_game()

    system("clear")
    save = Save.new()

    if File.exist?(SAVE_FILE)
      load_options(save)
    else
      save.new_data
    end

    loop do
      play_round(save)

      won = save.word == save.guess
      lost = save.guesses_left == 0

      if won || lost
        end_game(won, save)
        break
      end
    end

  end

  def load_options(save)

    positive = ["yes", "y"]
    negative = ["no", "n"]

    puts "Load previous save?"

    loop do
      input = gets.chomp.downcase.strip

      if positive.include?(input)
        return save.load_data
      elsif negative.include?(input)
        return save.new_data
      else
        puts "Please enter yes or no."
      end
    end
  end

  def play_round(save)
    letter = get_input(save)
    word = save.word

    indexes = word.each_index.select { |i| word[i] == letter }

    if indexes.empty?
      save.guesses_left -= 1
    else
      indexes.each { |i| save.guess[i] = letter }
    end
  end

  def draw_scene(save)
    system("clear")
    wrong_guesses = 6 - save.guesses_left
    puts HANGMAN[wrong_guesses]
    puts save.guess.join(" ")
  end

  def get_input(save)

    loop do

      draw_scene(save)
      puts "Enter a guess (Press \"1\" to save and exit)"

      input = gets.chomp.downcase.strip
      if ("a".."z").include?(input)
        return input
      elsif input == "1"
        system("clear")
        save.save_data()
        puts "Game Saved. Have a nice day!"
        exit
      end
    end
  end

  def end_game(is_victory, save)

    save.delete_data()

    if is_victory
      system("clear")
      puts HANGMAN[7]
      puts save.guess.join(" ")
      puts "You Win!"
    else
      draw_scene(save)
      puts "You Lose... The word was \"#{save.word.join}\""
    end
  end

end

class Save

  attr_accessor(:word, :guess, :guesses_left)

  def initialize
    @word = []
    @guess =  []
    @guesses_left = 0
  end

  def new_data()
    words = File.readlines(WORDS_FILE, chomp: true)
    @word = words.select { |word| word.length >= 5 }.sample.chars
    @guess =  Array.new(@word.length, "_")
    @guesses_left = 6

    delete_data()

  end

  def save_data()
    File.write(SAVE_FILE, [@word, @guess, @guesses_left].to_json)
  end

  def load_data()
    data = JSON.parse(File.read(SAVE_FILE))
    @word = data[0]
    @guess = data[1]
    @guesses_left = data[2]
  end

  def delete_data()
    if File.exist?(SAVE_FILE)
      File.delete(SAVE_FILE)
    end
  end

end

game = Game.new()
puts game.play_game()
