require_relative "./models/board.rb"
require_relative "./models/game.rb"
require_relative "./models/player.rb"

require "tty-prompt"
require "pastel"

prompt = TTY::Prompt.new
pastel = Pastel.new

player1 = Player.new(1, "Player 1", :yellow)
player2 = Player.new(2, "Player 2", :red)

game = Game.new(player1: player1, player2: player2)

puts ""
puts "Welcome to Connect 4"
puts "===================="
puts ""
puts "The objective of the game is to place 4 tokens of the same color together in the board."
puts "It will be considered a valid sequence if the tokens are in the same row, column or even on a diagonal."
puts "Each player has a color and can add one token per turn. The first player to play will be decided randomly."
puts ""
puts "#{pastel.yellow("Player 1")} will place yellow tokens"
puts "#{pastel.red("Player 2")} will place red tokens"
puts ""
puts "Here is the initial empty board:"
puts ""
puts game.show
puts ""
puts "There is a header above the board to help you identify the columns. Those white zeros are placeholders,"
puts "the position is empty and a token can be added to it. Once a player places a token, it will move down"
puts "as far as it can in the selected column, stopping either if it reaches the end of the board or if it"
puts "encounters another token."
puts ""

puts "Press ENTER when you are ready to play"
gets
puts ""
puts "---------------------------------------------------------------------------------------------------------"
puts ""

system("clear")

players = [player1, player2].shuffle

current_player = players.first
puts "All right, let's begin. The first player to play will be #{pastel.send(current_player.color, current_player.name)}"
puts ""

turn = 0
index = 0

while !game.winner do
  placed = false
  current_player = players[index]
  next_player = players[index - 1]

  puts "#{pastel.send(current_player.color, current_player.name)} turn"
  puts "==============================================================="
  puts ""
  game.show
  puts ""

  while !placed do
    column = prompt.ask("Please, select a column to place your token:") do |q|
      q.in "1-7"
      q.messages[:range?] = "%{value} out of expected range %{in}"
    end

    if !game.add_token(current_player, column.to_i - 1)
      puts ""
      puts "Looks like you can't place your token on column #{column}. Select another one."
      puts ""
    else
      placed = true
    end
  end

  puts "Nice. Here is the board now:"
  puts ""
  game.show
  puts ""

  if (!game.winner)
    puts "Press enter to let #{next_player.name} play"
    gets
    turn += 1
    index = index == 0 ? 1 : 0
    system("clear")
  end
end

puts ""
puts "CONGRATULATIONS, #{pastel.send(game.winner.color, game.winner.name)}! You won."
puts ""
puts ""
