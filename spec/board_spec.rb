# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    it 'defines state as an array of length 6' do
      board = described_class.new
      expect(board.state.length).to eq 6
    end

    it 'defines each entry in state as an array of length 7' do
      board = described_class.new
      expect(board.state[0].length).to eq 7
    end

    it 'initializes all values in state to nil' do
      board = described_class.new
      non_nil_values = board.state.flatten.compact
      expect(non_nil_values.empty?).to be true
    end

    it 'creates separate array instances for each column' do
      board = described_class.new
      board.state[0][0] = true
      expect(board.state[1][0]).to be_nil
    end
  end

  describe '#valid_move?' do
    subject(:board) { described_class.new }

    it 'returns true if column is empty' do
      result = board.valid_move?(1)
      expect(result).to be true
    end

    it 'returns false if column is full' do
      (0...6).each do |i|
        board.state[i][1] = true
      end
      result = board.valid_move?(1)
      expect(result).to be false
    end

    it 'returns false if input is not a number' do
      result = board.valid_move?('cats')
      expect(result).to be false
    end

    it 'returns false if input is invalid column' do
      result = board.valid_move?(8)
      expect(result).to be false
    end

    it 'returns true if input is upper bound' do
      result = board.valid_move?(7)
      expect(result).to be true
    end
  end

  describe '#make_move' do
    subject(:board) { described_class.new }

    let(:player) { { color: 'red', name: 'george' } }

    it 'places piece at bottom of empty column' do
      expect { board.make_move(1, player) }.to change { board.state[5][0] }.to(player)
    end

    it 'places piece correctly in partly full column' do
      board.state[5][2] = player
      expect { board.make_move(3, player) }.to change { board.state[4][2] }.to(player)
    end

    it 'places piece at top of nearly full column' do
      col = 6
      (1...5).each do |row|
        board.state[row][col] = player
      end
      expect { board.make_move(col + 1, player) }.to change { board.state[0][col] }.to(player)
    end
  end
end
