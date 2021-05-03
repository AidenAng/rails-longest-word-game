require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten.sample(10)
  end

  def compute_score(attempt, time_taken)
    time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  end

  def score
    @user_input = params[:answer].split("")
    @grid = params[:letters]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:answer]}")
    json = JSON.parse(response.read)
    @user_input.each do |letter|
      if @grid.exclude? letter.downcase
        @score = "Sorry but #{params[:answer].upcase} cannot be built out of GRID"
      elsif json['found'] == false
        @score = "Sorry but #{params[:answer].upcase} does not seem to be a valid English word..."
      else
        @score = "Congratulations! #{params[:answer].upcase} is a valid English word!"
      end
    end
  end
end
