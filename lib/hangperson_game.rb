class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  
  attr_accessor :word, :guesses, :wrong_guesses, :guess_count
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @guess_count = 0
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
    
  def guess(letter)
    if not /^[a-z]/.match?(letter)
        raise ArgumentError
    elsif @wrong_guesses.include?(letter) or @guesses.include?(letter)
        return false
    elsif @word.include? letter
        @guesses += letter
    else
        @wrong_guesses += letter
        @guess_count += 1
    end
  end
          
  def word_with_guesses
    guessed_word = ""
    @word.each_char do |letter|
        if @guesses.include? letter
            guessed_word += letter
        else
            guessed_word += '-'
        end
    end
    return guessed_word
  end
  
  def win_lose_play
    if @word == word_with_guesses
        return :win
    elsif guess_count >= 7
        return :lose
    end
  end
    
end
