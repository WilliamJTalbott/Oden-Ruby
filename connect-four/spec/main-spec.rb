require_relative "../script"

RSpec.describe Board do
  describe "#winner_from?" do
    it "detects a horizontal win" do
      board = Board.new

      board.drop_piece(0, "X")
      board.drop_piece(1, "X")
      board.drop_piece(2, "X")
      row, column = board.drop_piece(3, "X")

      expect(board.winner_from?(row, column, "X")).to be true
    end

    it "detects a vertical win" do
      board = Board.new

      board.drop_piece(0, "X")
      board.drop_piece(0, "X")
      board.drop_piece(0, "X")
      row, column = board.drop_piece(0, "X")

      expect(board.winner_from?(row, column, "X")).to be true
    end

    it "detects a diagonal up-right win" do
      board = Board.new

      board.drop_piece(0, "X")

      board.drop_piece(1, "O")
      board.drop_piece(1, "X")

      board.drop_piece(2, "O")
      board.drop_piece(2, "O")
      board.drop_piece(2, "X")

      board.drop_piece(3, "O")
      board.drop_piece(3, "O")
      board.drop_piece(3, "O")
      row, column = board.drop_piece(3, "X")

      expect(board.winner_from?(row, column, "X")).to be true
    end

    it "detects a diagonal down-right win" do
      board = Board.new

      board.drop_piece(0, "O")
      board.drop_piece(0, "O")
      board.drop_piece(0, "O")
      board.drop_piece(0, "X")

      board.drop_piece(1, "O")
      board.drop_piece(1, "O")
      board.drop_piece(1, "X")

      board.drop_piece(2, "O")
      board.drop_piece(2, "X")

      row, column = board.drop_piece(3, "X")

      expect(board.winner_from?(row, column, "X")).to be true
    end

    it "returns false when there is no winner" do
      board = Board.new

      row, column = board.drop_piece(0, "X")
      board.drop_piece(1, "O")
      board.drop_piece(2, "X")

      expect(board.winner_from?(row, column, "X")).to be false
    end
  end
end

RSpec.describe Player do
  describe "#create_profile" do
    it "creates a player profile with a name and token symbol" do
      player = Player.new

      player.create_profile("William", "X")

      expect(player.name).to eq("William")
      expect(player.token).to eq("X")
    end
  end
end