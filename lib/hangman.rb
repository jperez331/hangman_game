

def game_start
  puts 'Welcome to hangman game, lets try to guess the word: '
  puts word_to_guess().gsub(/./, '*')
end


def word_to_guess
  words_array = []
  
  File.foreach('words.txt') do |word|
    if word.length >= 5
      words_array.push(word)
    end
  end
  words_array.sample
end

game_start