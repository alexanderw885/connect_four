# frozen_string_literal: true

require_relative 'board'

# Contains game state and logic
class Game
  attr_accessor :board, :current_player, :player_one, :player_two

  def initialize(board = Board.new)
    @player_one = create_player(:red, 'Player 1')
    @player_two = create_player(:yellow, 'Player 2')
    @current_player = @player_one
    @board = board
  end

  def play_game
    reset_game
    @player_one = create_player(:red, input_name(1))
    @player_two = create_player(:yellow, input_name(2))
    @current_player = @player_one
    take_turn
  end

  def take_turn
    move_col = take_valid_move
    @board.make_move(move_col, @current_player)
  end

  def create_player(color, name)
    { color: color,
      name: name }
  end

  def input_name(player_num = '')
    puts "Enter name for player #{player_num}:"
    gets.chomp
  end

  def take_valid_move
    loop do
      move = input_move
      return move if @board.valid_move?(move)

      puts 'Invalid move.'
    end
  end

  def input_move
    puts 'Enter row to place your piece'
    gets.chomp
  end

  def reset_game(board = Board.new)
    @board = board
  end
end
