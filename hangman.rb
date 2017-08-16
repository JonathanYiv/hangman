require_relative 'gameboard.rb'

class Hangman
	attr_accessor :gameboard, :lose, :win

	def initialize
		@gameboard = GameBoard.new
		@lose = false
		@win = false
	end

	def play
		welcome
		@gameboard.display
		instructions
		#prompt_load
		turns
	end

	def welcome
		puts %{
 _   _                                         
| | | |                                        
| |_| | __ _ _ __   __ _ _ __ ___   __ _ _ __  
|  _  |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_ \\ 
| | | | (_| | | | | (_| | | | | | | (_| | | | |
\\_| |_/\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|
                    __/ |                      
                   |___/                       
		}
	end

	def instructions
		puts "\nWelcome to Hangman!"
		puts "\nThe computer will select a random 5-12 letter word."
		puts "You can guess letters to figure the word out."
		puts "You have 5 Guesses until the man is 'hung' and you lose!"
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
		guess = gets.chomp
		until guess.downcase.match(/^[a-z]$/) && !@gameboard.all_guesses.include?(guess)
			print "\nHmm.. something is wrong. Please type in a letter from A through Z that you haven't guessed yet.\n> "
			guess = gets.chomp
		end
		guess
	end

	def turn
		print "\nWhat is your guess?\n> "
		@gameboard.update(get_guess)
	end

	def check_status
		@lose = true if @gameboard.incorrect_guesses.length == 5
		@win = true if !@gameboard.correct_guesses.include?("_")
	end

	def win
		puts "\nCongratulations! You've guessed the word!"
		again?
	end

	def lose
		puts "\nThe answer was '#{@gameboard.solution.join("")}.'"
		puts "Aww! You poor, poor thing. You've lost! Perhaps you ought to purchase a dictionary! Hahahaha!"
		again?
	end

	def again?
		print "\nWant to play again? Yes or No.\n> "
		initialize
		play if get_answer == "yes"
	end

	def get_answer
		answer = gets.chomp.downcase
		until answer == "yes" || answer == "no"
			print "\nExcuse me. Did you say 'yes' or 'no?'\n> "
			answer = gets.chomp.downcase
		end
		answer
	end

	def save
	end

	def load
	end
end

game = Hangman.new
game.play