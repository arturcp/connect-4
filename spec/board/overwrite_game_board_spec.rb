# frozen_string_literal: true

require_relative "../../models/board.rb"

RSpec.describe Board, "#overwrite_game_board" do
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
