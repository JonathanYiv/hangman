require_relative 'gameboard.rb'
require 'json'

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
		prompt_load
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
			prompt_save
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

	def prompt_save
		puts "\nDo you want to save this game for later?"
		print "WARNING: This will overwrite any existing savefile!\n> "
		save if get_answer == "yes"
	end

	def prompt_load
		print "\nDo you want to load any previously existing games?\n> "
		load if get_answer == "yes"
	end

	def save
		create_save
		initialize
		play
	end

	def create_save
		puts "\nAlrighty.. saving this game..."
		sleep(3)
		puts "\nAlmost there..."
		sleep(3)
		Dir.mkdir("./saves") if !Dir.exist?("./saves")
		savefile = File.open("./saves/savefile.json", "w")
		savefile.write(@gameboard.to_json)
		puts "\nDone! Creating new game in 3.."
		sleep(1)
		puts "\n2.."
		sleep(1)
		puts "\n1.."
		sleep(1)
	end

	def load
		@gameboard.load
		@gameboard.display
	end
end

game = Hangman.new
game.play
