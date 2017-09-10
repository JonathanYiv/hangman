require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/hangman.rb'

get '/' do
	erb :index
end

get '/start' do
	incorrect = 0
	erb :game, :locals => {:incorrect => incorrect + 1}
end

# a place to put reusable code snippets
helpers do 

end