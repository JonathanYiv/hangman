require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/hangman.rb'

enable :sessions

get '/' do
	erb :index
end

get '/newgame' do
	reset_variables
	redirect to("/start")
end

get '/start' do
	update_variables

	guess(params["letter"].downcase) if !params["letter"].nil?

	display

	redirect to("/win") if win?
	redirect to("/lose") if @incorrect > 5
	erb :game
end

get '/lose' do
	erb :lose
end

get '/win' do
	update_variables
	erb :win
end

helpers do 
	def update_variables
		@incorrect = session[:incorrect]
		@solution = session[:solution]
		session[:display] = ""
		@display = session[:display]
		@guesses = session[:guesses]
	end

	def reset_variables
		session[:incorrect] = 0
		session[:solution] = random_word
		session[:guesses] = []
	end

	def random_word
		File.open("lib/5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample.split("")
	end

	def display
		@solution.each { |letter| session[:display] << (@guesses.include?(letter) ? "#{letter} " : "___ ") }
	end

	def guess(letter)
		if !@guesses.include?(letter)
			session[:guesses] << letter
			session[:incorrect] += 1 if !@solution.include?(letter)
			@incorrect = session[:incorrect]
		end
	end

	def win?
		win = true
		@solution.each do |letter|
			win = false if !@guesses.include?(letter)
		end
		win
	end
end