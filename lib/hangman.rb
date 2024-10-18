class Hangman
  def initialize
    @words = word_to_guess
    @secret_word = @words.split('')
    @guesses = []
    @max_attempts = 6
    @attempts_left = @max_attempts
  end

  def play
    puts "Welcome to Hangman!"
    until game_over?
      display_word
      guess = get_guess
      process_guess(guess)
    end

    if won?
      puts "Congratulations! You guessed the word: #{@secret_word.join}"
    else
      puts "Sorry, you've been hanged! The word was: #{@secret_word.join}"
    end
  end

  private

  # Display the word with correct guesses or underscores
  def display_word
    display = @secret_word.map { |char| @guesses.include?(char) ? char : "_" }
    puts "\nWord: #{display.join(" ")}"
    puts "Guesses: #{@guesses.join(", ")}"
    puts "Attempts left: #{@attempts_left}"
  end

  # Get the player's guess
  def get_guess
    print "\nEnter a letter: "
    guess = gets.chomp.downcase
    if guess.match?(/^[a-z]$/) && !@guesses.include?(guess)
      @guesses << guess
    else
      puts "Invalid input or already guessed. Try again."
      get_guess
    end
    guess
  end

  # Process the guess and update attempts if the guess is incorrect
  def process_guess(guess)
    unless @secret_word.include?(guess)
      @attempts_left -= 1
      puts "Incorrect guess!"
    else
      puts "Good guess!"
    end
  end

  # Check if the player has won
  def won?
    (@secret_word - @guesses).empty?
  end

  # Check if the game is over
  def game_over?
    won? || @attempts_left <= 0
  end
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

# Start the game
game = Hangman.new
game.play
