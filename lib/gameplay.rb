class Gameplay 
  attr_accessor :max_incorrect_guesses, :incorrect_guesses, :letters_guessed
  def initialize
    @max_incorrect_guesses = 6
    @incorrect_guesses = 0
    @letters_guessed = []
    puts 'Welcome to Hangman!'
  end

  def begin
    @dictionary = []

    f = File.open("google-10000-english-no-swears.txt")

    while line = f.gets do
      if line.length > 4 && line.length < 13  
        @dictionary << line
      end
    end

    f.close

    select_secret_word

    display = Display.new(self)
    display.info
    display.build
  end

  def select_secret_word
    @secret_word = @dictionary.sample
    puts "The secret word is: #{@secret_word}" #debugging
  end
  
end