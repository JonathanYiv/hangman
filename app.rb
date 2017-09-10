require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/hangman.rb'

configure do
	enable :sessions
	set :session_secret, "secret"
end

incorrect = 0

get '/' do
	@session = session
	erb :index
end

get '/start' do
	session["guess"] = params["letter"]
	@session = session
	
	incorrect += 1 if !session["guess"].nil?
	redirect to("/lose") if incorrect > 5
	
	erb :game, :locals => {:incorrect => incorrect}
end

get '/lose' do
	incorrect = 0
	erb :lose
end

helpers do 

end

=begin
REUSABLE CODE

	def initialize
		@gameboard = GameBoard.new
		@lose = false
		@win = false
	end

	def play
		@gameboard.display
		turns
	end

	def turns
		while @lose == false && @win == false
			turn
			check_status
		end
		lose if @lose
		win if @win
	end

	def get_guess
		guess = gets.chomp.downcase
		prompt_save if guess == "save"
		until guess.match(/^[a-z]$/) && !@gameboard.all_guesses.include?(guess)
			print "\nHmm.. something is wrong. Please type in a letter from A through Z that you haven't guessed yet.\n> "
			guess = gets.chomp.downcase
			prompt_save if guess == "save"
		end
		guess
	end

	def turn
		@gameboard.update(get_guess)
	end

	def check_status
		@lose = true if @gameboard.incorrect_guesses.length == 5
		@win = true if !@gameboard.correct_guesses.include?("_")
	end

	def win
		again?
	end

	def lose
		again?
	end

	def again?
		initialize
		play if get_answer == "yes"
		exit
	end

	def get_answer
		answer = gets.chomp.downcase
		until answer == "yes" || answer == "no"
			print "\nExcuse me. Did you say 'yes' or 'no?'\n> "
			answer = gets.chomp.downcase
		end
		answer
	end

	def initialize
		@solution = random_solution
		@correct_guesses = Array.new(@solution.length, "_")
		@incorrect_guesses = []
	end

	def random_solution
		File.open("lib/5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample.split("")
	end

	def display
		display_gallows
		display_guesses
	end

	def display_gallows
		case @incorrect_guesses.length
		when 0
		when 1
		when 2
		when 3
		when 4
		when 5
		end
	end

	def display_guesses
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
=end