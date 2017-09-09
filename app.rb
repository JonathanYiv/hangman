require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/hangman.rb'

get '/' do
	erb :index, :locals => {:test => "test"}
end