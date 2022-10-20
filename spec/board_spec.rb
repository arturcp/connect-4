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

  describe "#[]" do
    subject(:board) { described_class.new }

    before { board.add(1, 3) }

    it "access the row of the game board" do
      expect(board[5][3]).to eq(1)
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
      board.add(player1_id, 0)
      board.add(player2_id, 1)
      board.add(player2_id, 0)
      board.add(player1_id, 1)

      expect(board.add(player1_id, 0)).to eq(false)
    end

    it "returns false when position is invalid" do
      expect(board.add(player1_id, 50)).to eq(false)
    end
  end
end
