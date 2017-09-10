require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/hangman.rb'

enable :sessions

incorrect = 0

get '/' do
	erb :index
end

get '/start' do
	session[:letter] = params["letter"]
	@letter = session[:letter]
	incorrect += 1 if @letter =~ /[A-Za-z]/
	redirect to("/lose") if incorrect > 5
	erb :game, :locals => {:incorrect => incorrect}
end

get '/lose' do
	@letter = session[:letter]
	incorrect = 0
	erb :lose
end

helpers do 
	def random_word
		File.open("lib/5desk.txt").readlines.collect { |word| word.strip.downcase }.select { |word| word.length > 4 && word.length < 13 }.sample.split("")
	end
end