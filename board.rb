class Board
  DEFAULT_NUMBER_OF_rows = 7
  DEFAULT_NUMBER_OF_COLUMNS = 8

  attr_reader :board, :number_of_columns, :number_of_rows

  def initialize(number_of_rows: DEFAULT_NUMBER_OF_rows, number_of_columns: DEFAULT_NUMBER_OF_COLUMNS)
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @board = []

    number_of_rows.times do |i|
      line = []
      number_of_columns.times { |j| line << 0 }
      board << line
    end
  end

  def add(player_id, column)
    placed = false
    i = number_of_rows - 1

    while !placed && i >= 0 do
      if board[i][column] == 0
        board[i][column] = player_id
        placed = true
      end

      i -= 1
    end

    placed
  end

  def [](i)
    @board[i]
  end
end
