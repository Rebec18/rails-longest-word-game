require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @attempt = params[:word]
    @english_word = english_word?(@attempt)
    @grid_word = grid_word?(@attempt)
    # if @grid_word != true
    #   "Sorry but #{@attempt.upcase} can't be built out of array"
    # elsif @english_word != true
    #   "Sorry but #{@attempt.upcase} does not seem to be a valid English word ... "
    # else
    #   "Congratulations! #{@attempt.upcase} is a valid English word"
    # end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_word = open(url).read
    user = JSON.parse(user_word)
    user['found']
  end

  def grid_word?(word)
    word_letters = word.chars
    word_letters.all? { |letter| params[:grid].include?(letter) }
  end
end
