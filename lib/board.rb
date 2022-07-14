# frozen_string_literal: true

# Connect-Four board class
class Board
  FIGURES = ['★', '♣'].shuffle
  ROWS = 6
  COLS = 7
  attr_reader :grid, :rows, :cols

  def initialize
    @grid = Array.new(ROWS) { Array.new(COLS) }
  end

  def mark(row, col, turn)
    @grid[row][col] = FIGURES[turn] if @grid[row][col].nil?
  end

  def cell_intersections(row_n, col_n)
    diagonals = diagonals(row_n, col_n)
    [row(row_n), column(col_n), diagonals[0], diagonals[1]]
  end

  def row(number)
    @grid[number]
  end

  def column(number)
    @grid.transpose[number] if number.between?(0, COLS - 1)
  end

  def diagonals(cell_x, cell_y)
    backward = []
    forward = []
    @grid.each_with_index do |row, y|
      x = cell_x - (cell_y - y)
      backward << row[x] if x.between?(0, COLS - 1)
      x = cell_x + (cell_y - y)
      forward << row[x] if x.between?(0, COLS - 1)
    end
    [backward, forward]
  end

  def print
    @grid.each do |row|
      p row
    end
  end
end
