class Board
  DEFAULT_NUMBER_OF_ROWS = 6
  DEFAULT_NUMBER_OF_COLUMNS = 7

  attr_reader :number_of_columns, :number_of_rows

  def initialize(number_of_rows: DEFAULT_NUMBER_OF_ROWS, number_of_columns: DEFAULT_NUMBER_OF_COLUMNS)
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @game_board = []

    number_of_rows.times do |i|
      line = []
      number_of_columns.times { |j| line << 0 }
      game_board << line
    end
  end

  def add_token(player_id, column)
    placed = false
    i = number_of_rows - 1

    while !placed && i >= 0 do
      if game_board[i][column] == 0
        game_board[i][column] = player_id
        placed = true
      end

      i -= 1
    end

    placed
  end

  def column(j)
    game_board.map { |row| row[j] }.compact
  end

  def inspect
    @game_board.freeze
  end

  def overwrite_game_board(game_board)
    return false unless valid_game_board?(game_board)

    @game_board = game_board
    @number_of_rows = game_board.length
    @number_of_columns = game_board[0].length

    true
  end

  def row(i)
    game_board[i] || []
  end

  def show
    number_of_rows.times do |i|
      number_of_columns.times do |j|
        print yield(i, j, game_board[i][j].freeze)
      end

      puts ""
    end;nil
  end

  private

  attr_reader :game_board

  def valid_game_board?(game_board)
    game_board && game_board.is_a?(Array) && game_board.length > 0 && game_board[0].length > 0
  end
end
