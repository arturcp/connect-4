# frozen_string_literal: true

require 'pastel'

require_relative './board.rb'

class Game
  attr_reader :player1, :player2

  def initialize(board: Board.new, player1:, player2:)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def add_token(player, column)
    board.add_token(player.id, column)
  end

  def show
    show_header
    show_tokens
  end

  private

  attr_reader :board

  def board_position(row, column, token)
    player_id = token
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

  def show_header
    line_length = 0
    board.number_of_columns.times do |j|
      index = j + 1
      header = "#{index < 10 ? " " : ""}#{index} "
      line_length += header.length
      print header
    end
    puts ""
    puts "-" * line_length
  end

  def show_tokens
    board.show do |i, j, token|
      " #{board_position(i, j, token)} "
    end
  end
end
