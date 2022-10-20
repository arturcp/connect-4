# frozen_string_literal: true

require 'pastel'

class Game
  attr_reader :board, :player1, :player2, :players

  def initialize(board:, player1:, player2:)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def show
    board.number_of_rows.times do |i|
      board.number_of_columns.times do |j|
        print "#{board_position(i, j)} "
      end

      puts ""
    end;nil
  end

  private

  def board_position(row, column)
    player_id = board[row][column]
    player = player_by_id(player_id)
    color = player&.color || :white
    pastel.send(color.to_sym, "0")
  end

  def pastel
    @pastel = Pastel.new
  end

  def player_by_id(id)
    return player1 if id == player1.id
    return player2 if id == player2.id

    nil
  end
end
