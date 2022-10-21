# frozen_string_literal: true

require_relative "../../models/board.rb"

RSpec.describe Board, "#secondary_diagonal" do
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
    it { expect(board.secondary_diagonal(5, 2)).to be_empty }
  end

  context "when column is out of bounds" do
    it { expect(board.secondary_diagonal(2, 5)).to be_empty }
  end

  context "when row and column are valid" do
    it { expect(board.secondary_diagonal(3, 1)).to eq([21, 17, 13, 9, 5]) }
    it { expect(board.secondary_diagonal(1, 3)).to eq([21, 17, 13, 9, 5]) }
    it { expect(board.secondary_diagonal(1, 0)).to eq([6, 2]) }
    it { expect(board.secondary_diagonal(4, 4)).to eq([25]) }
    it { expect(board.secondary_diagonal(2, 1)).to eq([16, 12, 8, 4]) }
  end
end
