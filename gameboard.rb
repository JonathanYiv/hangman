class GameBoard
	attr_accessor :solution, :correct_guesses, :incorrect_guesses

	def initialize
		@solution = random_solution
		@correct_guesses = Array.new(@solution.length, "_")
		@incorrect_guesses = []
	end

	def random_solution
		word = File.open("5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample.split("")
	end

	def display
		display_gallows
		display_guesses
	end

	def display_gallows
		case @incorrect_guesses.length
		when 0
		puts "  ______"
		puts "  |   \\|"
		puts "       |"
		puts "       |"
		puts "       |"
		puts "       |"
		puts "-------^-------"
		when 1
		puts "  ______"
		puts "  |   \\|"
		puts "  O    |"
		puts "       |"
		puts "       |"
		puts "       |"
		puts "-------^-------"
		when 2
		puts "  ______"
		puts "  |   \\|"
		puts "  O    |"
		puts "  |    |"
		puts "       |"
		puts "       |"
		puts "-------^-------"
		when 3
		puts "  ______"
		puts "  |   \\|"
		puts "  O    |"
		puts " -|    |"
		puts "       |"
		puts "       |"
		puts "-------^-------"
		when 4
		puts "  ______"
		puts "  |   \\|"
		puts "  O    |"
		puts " -|-   |"
		puts "       |"
		puts "       |"
		puts "-------^-------"
		when 5
		puts "  ______"
		puts "  |   \\|"
		puts "  O    |"
		puts " -|-   |"
		puts "  ^    |"
		puts "       |"
		puts "-------^-------"
		end
	end

	def display_guesses
		puts "\nIncorrect Guesses: #{@incorrect_guesses.join(", ")}"
		puts "Word: #{@correct_guesses.join(" ")}"
	end

	def update(guess)
		evaluate_guess(guess)
		display
	end

	def evaluate_guess(guess)
		if @solution.include?(guess)
			matching = @solution.each_index.select { |i| @solution[i] == guess }
			matching.each { |i| @correct_guesses[i] = guess }
		else
			@incorrect_guesses << guess
		end
	end

	def all_guesses
		@correct_guesses + @incorrect_guesses
	end
end