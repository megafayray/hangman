@dictionary = []

f = File.open("google-10000-english-no-swears.txt")

while line = f.gets do
  if line.length > 4 && line.length < 13  
    @dictionary << line
  end
end

f.close

def select_secret_word
  @secret_word = @dictionary.sample
  puts @secret_word #debugging
end

select_secret_word