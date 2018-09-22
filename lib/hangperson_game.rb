class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
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
    
  def self.guess(letter)
    if not /^[[:alpha]]/.match?(letter.downcase!)
        raise ArgumentError
    if @guesses.include? letter
        return false
    elsif @word.include? letter
        @guesses += letter
    else
        @wrong_guesses += letter
    end
  end
          
  def self.word_with_guesses
    word_with_guesses = ""
    @word.each do |letter|
        if @guesses.include? letter
            word_with_guesses += letter
        else
            word_with_guesses += '-'
        end
    end
    return word_with_guesses
end
