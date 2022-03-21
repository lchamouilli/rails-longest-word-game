require "json"
require "open-uri"
require "csv"

class GamesController < ApplicationController
  def new
    @letters = *('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @score = 0
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user['found']
    valid_english_word = (@word.split('') - @letters.split('')).empty?
    if valid_english_word && user['found']
      @result = "Congratulations! #{@word.capitalize} is a valid English word"
      @score += @word.size
    elsif valid_english_word && user['found'] == false
      @result = "Sorry but #{@word.capitalize} does not seem to be a valid English word..."
    else
      @result = "Sorry but #{@word.capitalize} can't be build of #{@letters}"
    end
  end
end
