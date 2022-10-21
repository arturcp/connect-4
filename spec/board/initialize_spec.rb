# frozen_string_literal: true

require_relative "../../models/board.rb"

RSpec.describe Board, "#initialize" do
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
