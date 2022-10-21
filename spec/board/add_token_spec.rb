# frozen_string_literal: true

require_relative "../../models/board.rb"

RSpec.describe Board, "#add_token" do
  subject(:board) { described_class.new(number_of_rows: 2, number_of_columns: 2) }

  let(:player1_id) { 1 }
  let(:player2_id) { 2 }

  it "adds the tokens into the desired positions" do
    board.add_token(player1_id, 0)
    board.add_token(player2_id, 1)
    board.add_token(player2_id, 0)
    board.add_token(player1_id, 1)

    expect(board.inspect).to eq([
      [2, 1],
      [1, 2]
    ])
  end

  it "returns true when the token was placed" do
    expect(board.add_token(player1_id, 0)).to eq(true)
  end

  it "returns false when the token was not placed" do
    board.overwrite_game_board([
      [2, 1],
      [1, 2]
    ])

    expect(board.add_token(player1_id, 0)).to eq(false)
  end

  it "returns false when position is invalid" do
    expect(board.add_token(player1_id, 50)).to eq(false)
  end
end
