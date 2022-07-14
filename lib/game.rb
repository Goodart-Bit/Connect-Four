# frozen_string_literal: true

require_relative 'board'
# Connect-four game logic
class Game
  def initialize(board = Board.new)
    @board = board
    @turn = 1
  end

  def play
    loop do
      puts "Player's #{@turn} turn"
      token_coords = place_token
      @board.print
      break if ending_move?(token_coords[0], token_coords[1])

      @turn = @turn == 1 ? 2 : 1
    end
    puts "Player #{@turn} wins!"
  end

  def place_token(row = player_input('row'), column = player_input('column'))
    loop do
      break if @board.mark(row, column, @turn - 1)

      puts "the cell located in row #{row} and column #{column} already has a token, insert another position"
      row = player_input('row')
      column = player_input('column')
    end
    [row, column]
  end

  def player_input(destination)
    loop do
      puts "Insert a #{destination} number to place the token:"
      input = gets.chomp
      return input.to_i if input.match(/\d/) && validate_move(input.to_i, destination)

      puts 'invalid input, try again'
    end
  end

  def validate_move(move, destination)
    case destination
    when 'row'
      true if move.between?(0, Board::ROWS - 1)
    when 'column'
      true if move.between?(0, Board::COLS - 1)
    end
  end

  def ending_move?(row, column)
    intersections = @board.cell_intersections(row, column)
    intersections.each do |intersection|
      intersection_str = intersection.join
      if intersection_str.include?(Board::FIGURES[0] * 4) || intersection_str.include?(Board::FIGURES[1] * 4)
        return true
      end
    end
    false
  end
end
