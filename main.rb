require_relative 'board.rb'
require_relative 'game.rb'
require_relative 'player.rb'

require 'tty-prompt'

prompt = TTY::Prompt.new

board = Board.new(number_of_rows: 4, number_of_columns: 15)
player1 = Player.new(1, :yellow)
player2 = Player.new(2, :red)

game = Game.new(board: board, player1: player1, player2: player2)

puts game.show

game.board.add(player1.id, 3)

puts game.show


# prompt.ask("Choose a column to place your ? ") do |q|
#   q.in "1-5"
#   q.messages[:range?] = "%{value} out of expected range %{in}"
# end
