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

  # Given a starting element e(r, c) from the matrix m, a primary diagonal will be a list of consecutive elments a(i,j)
  # where the difference `j - i` is exactly the same as the `c - r` from the element e.
  #
  # Example:
  #
  #  1,  2,  3,  4,  5
  #  6,  7,  8,  9, 10
  # 11, 12, 13, 14, 15
  # 16, 17, 18, 19, 20
  # 21, 22, 23, 24, 25
  #
  # Taking as a starting point the element a(3, 1) = 17, the primary diagonal will be [11, 17, 23]. Here is a visual
  # representation:
  #
  #    1,    2,    3,  4,  5
  #    6,    7,    8,  9, 10
  # [11],   12,   13, 14, 15
  #   16, [17],   18, 19, 20
  #   21,   22, [23], 24, 25
  #
  # The result is comprised of the elements (2, 0), (3, 1) and (4, 2). Notice that the initial element was (3, 1) and
  # the difference j - i was 1 - 3 = -2. All elements from the resulting list contains the same difference:
  #
  # * 0 - 2 = -2
  # * 1 - 3 = -2
  # * 2 - 4 = -2
  def primary_diagonal(row, column)
    return [] if row < 0 || row >= number_of_rows || column < 0 || column >= number_of_columns

    current_row = row
    current_column = column

    while current_row > 0 && current_column > 0 do
      current_row -= 1
      current_column -= 1
    end

    result = []
    while current_row < number_of_rows && current_column < number_of_columns do
      result << game_board[current_row][current_column]
      current_row += 1
      current_column += 1
    end

    result
  end

  def row(i)
    game_board[i] || []
  end

  def secondary_diagonal(row, column)
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
