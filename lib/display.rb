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

  def request_guess
    input = gets.chomp.downcase
    if @gameplay.secret_word.include?(input)
      @gameplay.secret_word.chars.each_with_index do | char, index | #.chars method converts a string into an array of its individual characters
        if char == input
          @spaces[index] = input
        end
      end
    else
      @gameplay.incorrect_guesses += 1 
    end

    @gameplay.letters_guessed << input
    info
    puts @spaces.join(' ')
  end
end
