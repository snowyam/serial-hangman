# Serial Hangman

class Noose
  attr_accessor :word, :turn
  def initialize(word, turn)
    @word = word
    @turn = turn
    @wrong_guesses = []
    @word_progess = ""
    word.split("").each do |i|
      @word_guesses << "_"
    end
  end

  def turns_left
    @turn -= 1
  end

  def guessed(guess)

  end

  def display_word_progress
    puts @word_progess
  end

  def display_wrong
    p @wrong_guesses
  end

  def display_answer
    puts @word
  end

  def update_word

  end

  def update_wrong

  end

end

def save_game

end

def load_game

end

def display_main_menu
  puts "1. Play!"
  puts "2. Load Save"
  puts "Enter # option: "
  option = gets.chomp
end

def guess_input(guess)
  while /[[:alpha]]/.match(guess) == nil
      puts "Invalid guess, try again:"
      guess = gets.chomp
  end
  guess = guess.downcase!
  if guess == "save"
    save_game#TODO
    guess = guess_input(gets.chomp)
  end
end

def get_word

end

# Main game loop
exit = false
start = true

while !exit
  # Main menu: Start game, load word, load game option
  if start == true
    choice = display_main_menu
    if choice == 2
      load_game
    else
      #TODO choose word.
    end
    start = false
  end

  if turns_left != 0
    puts
    puts "Enter 'save' into prompt to save."
    print "Hangman: "
    display_word_progress
    puts
    print "Attempts: "
    display_wrong
    puts
    puts "Enter your guess(single letter or entire word):"
    guess = guess_input(gets.chomp)

    exit = true
end