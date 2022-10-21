# frozen_string_literal: true

require_relative "../../models/board.rb"

RSpec.describe Board, "#column" do
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
