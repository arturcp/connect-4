# frozen_string_literal: true

require_relative "../../models/board.rb"
require_relative "../../models/game.rb"
require_relative "../../models/player.rb"

require "byebug"

RSpec.describe Game, "#add_token" do
  subject(:game) { described_class.new(board: board, player1: player1, player2: player2) }

  let(:board) { Board.new }
  let(:player1) { Player.new(1, :yellow) }
  let(:player2) { Player.new(2, :red) }

  it "delegates the responsibility to the board" do
    expect(board).to receive(:add_token).with(player1.id, 2).and_call_original

    game.add_token(player1, 2)
  end

  it "checks if there is a winner" do
    expect(game).to receive(:check_if_there_is_a_winner).with(anything, player1)

    game.add_token(player1, 2)
  end

  it "returns false when there is already a winner" do
    expect(board).not_to receive(:add_token)
    expect(game).not_to receive(:check_if_there_is_a_winner)

    allow(game).to receive(:winner).and_return(player1)

    expect(game.add_token(player1, 2)).to eq(false)
  end

  context "when finding a winner" do
    it "finds a winner when there are 4 tokens in a row" do
      board.overwrite_game_board([
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 1, 1, 1, 0]
      ])

      expect(game.winner).to be_nil

      game.add_token(player1, 4)

      expect(game.winner).to eq(player1)
    end

    it "finds a winner when there are 4 tokens in a column" do
      board.overwrite_game_board([
        [0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0],
        [0, 1, 1, 0, 0],
        [0, 1, 1, 1, 0]
      ])

      expect(game.winner).to be_nil

      game.add_token(player1, 1)

      expect(game.winner).to eq(player1)
    end

    it "finds a winner when there are 4 tokens in the primary diagonal" do
      board.overwrite_game_board([
        [0, 0, 0, 2, 0],
        [1, 1, 0, 0, 2],
        [1, 1, 1, 0, 0],
        [1, 1, 1, 0, 0]
      ])

      expect(game.winner).to be_nil

      game.add_token(player1, 0)

      expect(game.winner).to eq(player1)
    end

    it "finds a winner when there are 4 tokens in the secondary diagonal" do
      board.overwrite_game_board([
        [1, 0, 0, 0, 0],
        [0, 1, 1, 0, 0],
        [1, 2, 1, 0, 0],
        [1, 2, 1, 0, 2]
      ])

      expect(game.winner).to be_nil

      game.add_token(player1, 3)

      expect(game.winner).to eq(player1)
    end

    it "discovers there are no winners yet" do
      board.overwrite_game_board([
        [1, 0, 0, 0, 0],
        [0, 1, 1, 0, 0],
        [1, 2, 1, 0, 0],
        [1, 2, 1, 0, 2]
      ])

      expect(game.winner).to be_nil

      game.add_token(player1, 4)

      expect(game.winner).to be_nil
    end
  end
end
