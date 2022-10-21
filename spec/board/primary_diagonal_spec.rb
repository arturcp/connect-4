# frozen_string_literal: true

require_relative "../../models/board.rb"

RSpec.describe Board, "#primary_diagonal" do
  subject(:board) { described_class.new(number_of_rows: 5, number_of_columns: 5) }

  before do
    board.overwrite_game_board([
      [ 1,  2,  3,  4,  5],
      [ 6,  7,  8,  9, 10],
      [11, 12, 13, 14, 15],
      [16, 17, 18, 19, 20],
      [21, 22, 23, 24, 25]
    ])
  end

  context "when row is out of bounds" do
    it { expect(board.primary_diagonal(5, 2)).to be_empty }
  end

  context "when column is out of bounds" do
    it { expect(board.primary_diagonal(2, 5)).to be_empty }
  end

  context "when row and column are valid" do
    it { expect(board.primary_diagonal(3, 1)).to eq([11, 17, 23]) }
    it { expect(board.primary_diagonal(1, 4)).to eq([4, 10]) }
    it { expect(board.primary_diagonal(2, 2)).to eq([1, 7, 13, 19, 25]) }
    it { expect(board.primary_diagonal(4, 0)).to eq([21]) }
    it { expect(board.primary_diagonal(2, 1)).to eq([6, 12, 18, 24]) }
  end
end
