class GameBoard
	attr_accessor :solution, :guesses

	def initialize
		@solution = random_solution
		@guesses = Array.new(@solution.length, "_")
	end

	def random_solution
	end

	def display
		display_gallows
		display_guesses
	end

	def display_gallows
	end

	def display_guesses
	end

	def update
		evaluate_guess
		display
	end

	def evaluate_guess
	end
end