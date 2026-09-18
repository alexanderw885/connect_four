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

  def over?
  end

  def check_row(row)
    accumulator = { longest_streak: 0,
                    longest_streak_player: false,
                    current_streak_player: false,
                    current_streak: 0 }
    @state[row].each do |token|
      evaluate_token(accumulator, token)
    end
    accumulator[:longest_streak_player]
  end

  def evaluate_token(acc, token)
    reset_streak(acc, false) if token.nil?
    if token == acc[:current_streak_player]
      acc[:current_streak] += 1
      if acc[:longest_streak] < acc[:current_streak]
        acc[:longest_streak] = acc[:current_streak]
        acc[:longest_streak_player] = acc[:current_streak_player]
      end
    else
      reset_streak(acc, token)
    end
  end

  def reset_streak(acc, token)
    acc[:current_streak] = 1
    acc[:current_streak_player] = token
  end

  def check_col
  end

  def check_diag
  end

  def board_full?
  end
end
