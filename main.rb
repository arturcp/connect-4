require_relative './models/board.rb'
require_relative './models/game.rb'
require_relative './models/player.rb'

require 'tty-prompt'

prompt = TTY::Prompt.new

player1 = Player.new(1, :yellow)
player2 = Player.new(2, :red)

game = Game.new(player1: player1, player2: player2)

puts game.show

game.add_token(player1, 3)

puts game.show


# prompt.ask("Choose a column to place your ? ") do |q|
#   q.in "1-5"
#   q.messages[:range?] = "%{value} out of expected range %{in}"
# end
