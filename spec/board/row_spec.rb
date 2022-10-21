# frozen_string_literal: true

require_relative "../../models/board.rb"

RSpec.describe Board, "#row" do
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
