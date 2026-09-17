# frozen_string_literal: true

# Stores state of board, performs all logic related to board
# Positions on the board state are called state[row][col]
# state[0][0] is the top-left corner
class Board
  attr_accessor :state

  def initialize(width = 7, height = 6, num_to_win = 4)
    @width = width
    @height = height
    @num_to_win = num_to_win
    @state = Array.new(height)
    @state.map! { Array.new(width, nil) }
  end

  def valid_move?(col)
    return false unless col.is_a?(Integer)

    return false unless col.positive? && col <= @width

    state[0][col].nil?
  end

  def make_move(col, token)
    (0...@height).reverse_each do |height|
      next unless @state[height][col - 1].nil?

      @state[height][col - 1] = token
    end
  end
end
