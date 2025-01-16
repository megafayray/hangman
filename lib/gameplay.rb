require 'yaml'

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

    @display = Display.new(self)

    if File.exist?('savedgame.yml')
      puts "Would you like to play a saved game? Enter 'y' or 'n'"
      choice = gets.chomp.downcase

      if choice == 'y'
        load_saved_game
      elsif choice == 'n'
        start_new_game
      end

    else
      start_new_game
    end
  end

  def start_new_game
    select_secret_word
    @display.build
    @display.info
    cycle
  end

  def load_saved_game
    saved_data = YAML.load_file('savedgame.yml')

    @letters_guessed = saved_data[:letters_guessed]
    @incorrect_guesses = saved_data[:incorrect_guesses]
    @secret_word = saved_data[:secret_word]
    
    @display.spaces = saved_data[:spaces].split(' ')  # Make sure the spaces are correctly formatted
    @display.info
    puts @display.spaces.join(' ')
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