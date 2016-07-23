# Serial Hangman

require 'yaml'

class Noose
  attr_accessor :word, :turn, :wrong_guesses, :word_progress
  def initialize(word, turn)
    @word = word
    @turn = turn
    @wrong_guesses = []
    @word_progress = ""
    word.split("").each do |i|
      @word_progress << ("_")
    end
  end

  def turns_left
    @turn -= 1
    puts "#{@turn} guesses remaining!\n"
    @turn
  end

  def guessed(guess)
    system "clear"
    puts "Your guess: #{guess}"
    if guess.length > 1
      if guess == @word
        puts
        puts "You've won!\n\n"
        @turn = 1
      else
        puts "\nNope! Try again!\n\n"
      end
    else
      if /#{guess}/.match(@word) != nil
        puts "\nA match!\n\n"
        update_word(guess)
      else
        puts "\nNope! Try again!\n\n"
        update_wrong(guess)
      end
    end
  end

  def display_word_progress
    puts @word_progress
  end

  def display_wrong
    p @wrong_guesses
  end

  def display_answer
    puts @word
  end

  def update_word(guess)
    @word.each_char.with_index do |char, index|
      if char == guess
        @word_progress[index] = char
      end
    end
    if @word == @word_progress
      puts
      puts "You've won!\n"
      @turn = 1
    end
  end

  def update_wrong(guess)
    @wrong_guesses << guess
  end

end

def save_game(noose_object)
  yaml = YAML::dump(noose_object)
  save_file = File.open("data/save.yaml", "w")
  save_file.write(yaml)
end

def load_game
  if File.exist?("data/save.yaml")
    save_file = File.open("data/save.yaml")
    yaml = save_file.read
    noose = YAML::load(yaml)  
  else
    puts "No saved file detected. Starting new game.\n"
    chosen_word = get_word
    noose = Noose.new(chosen_word, chosen_word.length + 2)
  end
  noose
end

def display_main_menu
  system "clear"
  puts "1. Play!"
  puts "2. Load Save"
  print "Enter # option: "
  option = gets.chomp
  system "clear"
  return option
end

def guess_input(guess, noose)
  guess = guess.to_s.downcase
  if guess == "save"
    save_game(noose)
    puts "\nGame saved!\n"
    puts "Enter your guess(single letter or entire word):" 
    guess = guess_input(gets.chomp, noose)
  end
  guess
end

def get_word
  dict = File.readlines("data/dict.txt").sample.chomp.downcase
  while dict.length < 5
    dict = File.readlines("data/dict.txt").sample.chomp.downcase
  end
  return dict
end

# Main game loop
exit = false
start = true

while !exit
  # Main menu: Start game, load word, load game option
  if start == true
    choice = display_main_menu
    if choice == "2"
      noose = load_game
    else
      chosen_word = get_word
      noose = Noose.new(chosen_word, chosen_word.length + 2)
    end
    start = false
  end

  if noose.turns_left > 0
    puts
    puts "Enter 'save' into prompt to save.\n\n"
    print "Hangman: "
    noose.display_word_progress
    puts
    print "Attempts: "
    noose.display_wrong
    puts
    puts "Enter your guess(single letter or entire word):"
    guess = guess_input(gets.chomp, noose)
    noose.guessed(guess)
  else
    print "Answer: "
    noose.display_answer 
    puts "\nGame over!\n"
    exit = true
  end
end