require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:new_word]
    get_result(@word)
  end

  def get_result(word)
    word_array = word.chars
    @letters = params[:random_grid].split('')
    if !english?(word)
      @result = "Sorry but #{word} is not an English word!"
    elsif (word_array - @letters).empty?
      @result = "#{word} is a great word!"
    else
      @result = "#{word} doesn't include #{@letters.join('')}"
    end
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_word = open(url).read
    english_word = JSON.parse(serialized_word)
    english_word['found']
  end
end
