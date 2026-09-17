# frozen_string_literal: true

require_relative 'lib/game'

game = Game.new

game.player_one = game.create_player(:orange, 'really new name')

p game.current_player[:name]
