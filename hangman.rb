require_relative 'gameboard.rb'

class Hangman
	attr_accessor :gameboard

	def initialize
		@gameboard = GameBoard.new
	end

	def play
		@gameboard.display
		instructions
		#prompt_load
		turns
	end

	def instructions
	end

	def turns
	end

	def turn
	end

	def save
	end

	def load
	end
end

game = Hangman.new
game.play