class Display 
  def initialize(gameplay)
    @gameplay = gameplay
  end

  def info
    puts "Maximum incorrect guesses allowed: #{@gameplay.max_incorrect_guesses}"
    puts "Letters guessed: #{@gameplay.letters_guessed}"
    puts "Incorrect guesses: #{@gameplay.incorrect_guesses}"
  end

  def build
    
  end
end
