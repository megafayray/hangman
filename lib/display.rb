require 'yaml'

class Display
  attr_accessor :spaces

  def initialize(gameplay)
    @gameplay = gameplay
  end

  def info
    puts "Maximum incorrect guesses allowed: #{@gameplay.max_incorrect_guesses}"
    puts "Letters guessed: #{@gameplay.letters_guessed}"
    puts "Incorrect guesses: #{@gameplay.incorrect_guesses}"
  end

  def build
    i = 0
    @spaces = []
    until i == @gameplay.secret_word.length - 1
      @spaces << '_ '
      i += 1
    end
    puts @spaces.join(' ')
  end

  def request_guess
    puts 'To save the game, press the Esc button. Otherwise, guess a letter'
    @input = gets.chomp.downcase
    save_game?
    if @gameplay.secret_word.include?(@input)
      @gameplay.secret_word.chars.each_with_index do |char, index| # .chars method converts a string into an array of its individual characters
        @spaces[index] = @input if char == @input
      end
    elsif @input != "\e"
      @gameplay.incorrect_guesses += 1
    end

    @gameplay.letters_guessed << @input if @input != "\e"

    info
    puts @spaces.join(' ')
  end

  private

  def save_game?
    return unless @input == "\e"

    File.open('savedgame.yml', 'w') do |file|
      file.write(YAML.dump({
                             letters_guessed: @gameplay.letters_guessed,
                             incorrect_guesses: @gameplay.incorrect_guesses,
                             secret_word: @gameplay.secret_word.chomp,
                             spaces: @spaces.join(' ')
                           }))
    end
  end
end
