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
      @spaces << "_ "
      i += 1
    end
    puts @spaces.join(' ')
  end

  def save_game? #maybe this should be private
    if @input == "\e"
      savedgame = File.new('savedgame.txt', 'w')
      savedgame.puts File.mtime 'savedgame.txt'
      savedgame.puts "Letters guessed: #{@gameplay.letters_guessed}"
      savedgame.puts "Number of incorrect guesses: #{@gameplay.incorrect_guesses}"
      savedgame.puts "Current saved spaces to display: #{@spaces.join(' ')}"

      savedgame.close
    end
  end

  def request_guess
    puts "To save the game, press the Esc button. Otherwise, guess a letter"
    @input = gets.chomp.downcase
    save_game?
    if @gameplay.secret_word.include?(@input)
      @gameplay.secret_word.chars.each_with_index do | char, index | #.chars method converts a string into an array of its individual characters
        if char == @input
          @spaces[index] = @input
        end
      end
    elsif @input != "\e"
      @gameplay.incorrect_guesses += 1 
    end

    if @input != "\e"
      @gameplay.letters_guessed << @input
    end

    info
    puts @spaces.join(' ')
  end
end
