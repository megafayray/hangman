class Gameplay 
  attr_accessor :max_incorrect_guesses, :incorrect_guesses, :letters_guessed, :secret_word
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

    @display = Display.new(self)
    @display.info
    @display.build

    cycle
  end

  def select_secret_word
    @secret_word = @dictionary.sample
    puts "The secret word is: #{@secret_word}" #for testing
  end

  def cycle
    until gameover
      @display.request_guess
    end

    puts "You #{@result}!"
    puts "The secret word was... #{@secret_word}"
  end

  def gameover
    if @incorrect_guesses > @max_incorrect_guesses
      @result = "lost"
      return true
    end
    if !@display.spaces.join.include?('_')
      @result = "won"
      return true
    end
  end
  
end