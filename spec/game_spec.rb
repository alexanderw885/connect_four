require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  describe '#create_player' do
    subject(:game) { described_class.new }

    it 'returns hash with color key' do
      player = game.create_player(:red, 'player')
      expect(player).to have_key(:color)
    end

    it 'returns hash with properly set color' do
      player = game.create_player(:green, 'player')
      expect(player[:color]).to eq :green
    end

    it 'returns hash with name key' do
      player = game.create_player(:blue, 'player')
      expect(player).to have_key(:name)
    end
  end

  describe '#reset_game' do
    subject(:game) { described_class.new }

    it 'resets board to empty board' do
      game.reset_game
      board = game.board.state
      all_nil = board.flatten.reduce(true) { |acc, val| acc && val.nil? }
      expect(all_nil).to be true
    end

    it 'resets current_player to player 1' do
      game.reset_game
      player_one = game.current_player
      expect(player_one).to equal game.player_one
    end
  end
end
