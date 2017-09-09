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
		prompt_load if Dir.exist?("./saves")
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
		puts "Type 'save' on your turn to save the game for later."
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
		number = get_save_number
		pre_save
		create_save(number)
		post_save
		initialize
		play
	end

	def get_save_number
		puts "\nWhat Save File would you like to save this game in?"
		get_number
	end

	def create_save(number)
		Dir.mkdir("./saves") if !Dir.exist?("./saves")
		savefile = File.open("./saves/savefile#{number}.json", "w")
		savefile.write(@gameboard.to_json)
	end

	def pre_save
		puts "\nAlrighty.. saving this game..."
		sleep(3)
		puts "\nAlmost there..."
		sleep(3)
	end

	def post_save
		puts "\nDone! Creating new game in 3.."
		sleep(1)
		puts "\n2.."
		sleep(1)
		puts "\n1.."
		sleep(1)
	end

	def load
		@gameboard.load(get_load_number)
		@gameboard.display
	end

	def get_load_number
		puts "\nWhat Save File would you like to load?"
		get_number
	end

	def get_number
		print "Type 1, 2, or 3.\n> "
		answer = gets.chomp
		until answer.match(/[1-3]/) && File.exist?("./saves/savefile#{answer}.json")
			print "\nTry again: 1, 2, or 3.\n> "
			answer = gets.chomp
		end
		answer
	end
end