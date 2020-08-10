require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params['word'].upcase
    @letters = params['letters'].upcase
    @reply = ""

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    result_serialized = open(url).read
    result = JSON.parse(result_serialized)

    @in_grid = @word.chars.all? do |char|
      @word.count(char) <= @letters.count(char)
    end

    if @in_grid == false
      @reply = "Sorry, #{params['word'].upcase} can't be built out of #{@letters}"
    elsif result['found'] == true
      @reply = "Congratulations! #{params['word'].upcase} is a valid English word!"
    else
      @reply = "Sorry but #{params['word'].upcase} doesn't seem to be a valid English word..."
    end
  end
end

# You will use the Wagon Dictionary API. Let's have a look at what we get back from the API when we submit a correct English word and a wrong one. Pay attention to the structure of the URL.
# Your grid must be a random grid where it's possible to embed the same characters multiple times.
# Make sure you are validating that 1) your word is an actual English word, and 2) that every letter in your word appears in the grid (remember you can only use each letter once).
# If the word is not valid or is not in the grid, the score will be 0 (and should be accompanied by a message to the player explaining why they didn't score any points).
# The score depends on the time taken to answer, plus the length of the word you submit. The longer the word and the quicker the time, the better the score! Feel free to invent your own penalty rules too!
