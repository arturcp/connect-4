# frozen_string_literal: true

require_relative "../board.rb"

RSpec.describe Board do
  describe "#initialize" do
    it "creates a matrix with the correct number of rows and columns" do
      board = described_class.new(number_of_rows: 2, number_of_columns: 3)

      expect(board.inspect).to eq([
        [0, 0, 0],
        [0, 0, 0]
      ])
    end

    it "creates a matrix with the default number of rows and columns" do
      board = described_class.new

      expect(board.inspect).to eq([
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0]
      ])
    end
  end

  describe "#add" do
    subject(:board) { described_class.new(number_of_rows: 2, number_of_columns: 2) }

    let(:player1_id) { 1 }
    let(:player2_id) { 2 }

    it "adds the tokens into the desired positions" do
      board.add(player1_id, 0)
      board.add(player2_id, 1)
      board.add(player2_id, 0)
      board.add(player1_id, 1)

      expect(board.inspect).to eq([
        [2, 1],
        [1, 2]
      ])
    end

    it "returns true when the token was placed" do
      expect(board.add(player1_id, 0)).to eq(true)
    end

    it "returns false when the token was not placed" do
      board.overwrite_game_board([
        [2, 1],
        [1, 2]
      ])

      expect(board.add(player1_id, 0)).to eq(false)
    end

    it "returns false when position is invalid" do
      expect(board.add(player1_id, 50)).to eq(false)
    end
  end

  describe "column" do
    subject(:board) { described_class.new(number_of_rows: 3, number_of_columns: 3) }

    before do
      board.overwrite_game_board([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ])
    end

    it { expect(board.column(0)).to eq([1, 4, 7]) }
    it { expect(board.column(1)).to eq([2, 5, 8]) }
    it { expect(board.column(2)).to eq([3, 6, 9]) }
    it { expect(board.column(3)).to be_empty }
  end


  describe "#overwrite_game_board" do
    subject(:board) { described_class.new(number_of_rows: 3, number_of_columns: 3) }

    context "when new board is valid" do
      let(:expected_board) do
        [
          [1, 2],
          [3, 4]
        ]
      end

      it "access the row of the game board" do
        board.overwrite_game_board(expected_board)

        game_board = board.inspect
        expect(game_board).to eq(expected_board)
      end
    end

    context "when new board has no rows" do
      let(:expected_board) { [] }

      it { expect(board.overwrite_game_board(expected_board)).to eq(false) }

      it "does not change the game board" do
        game_board = board.inspect
        expect(game_board).to eq([
          [0, 0, 0],
          [0, 0, 0],
          [0, 0, 0]
        ])
      end
    end

    context "when new board has no columns" do
      let(:expected_board) { [[]] }

      it { expect(board.overwrite_game_board(expected_board)).to eq(false) }

      it "does not change the game board" do
        game_board = board.inspect
        expect(game_board).to eq([
          [0, 0, 0],
          [0, 0, 0],
          [0, 0, 0]
        ])
      end
    end

    context "when new board is nil" do
      let(:expected_board) { nil }

      it { expect(board.overwrite_game_board(expected_board)).to eq(false) }

      it "does not change the game board" do
        game_board = board.inspect
        expect(game_board).to eq([
          [0, 0, 0],
          [0, 0, 0],
          [0, 0, 0]
        ])
      end
    end

    context "when new board is not an array" do
      let(:expected_board) { {} }

      it { expect(board.overwrite_game_board(expected_board)).to eq(false) }

      it "does not change the game board" do
        game_board = board.inspect
        expect(game_board).to eq([
          [0, 0, 0],
          [0, 0, 0],
          [0, 0, 0]
        ])
      end
    end
  end

  describe "row" do
    subject(:board) { described_class.new(number_of_rows: 3, number_of_columns: 3) }

    before do
      board.overwrite_game_board([
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ])
    end

    it { expect(board.row(0)).to eq([1, 2, 3]) }
    it { expect(board.row(1)).to eq([4, 5, 6]) }
    it { expect(board.row(2)).to eq([7, 8, 9]) }
    it { expect(board.row(3)).to be_empty }
  end
end
