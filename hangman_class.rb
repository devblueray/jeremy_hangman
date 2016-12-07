class Hangman
    attr_accessor :word, :guessed_letters, :correct_guesses, :blank_word, :letter_guess, :chances
  
    def initialize(word)
        (@word = word).downcase!
        @correct_guesses = []
        @guessed_letters = []
        @blank_word = Array.new(word.length, "_")
        @letter_guess = ""
        @chances = 0
        
    end

    def input_secret_word
        @split_word = @word.split("")
    end

    # def word_exclude?(letter_guess)
    #     unless @split_word.include? letter_guess
    #         @chances = @chances - 1
    #     end
    # end

    def word_include?(letter_guess)
        @split_word.include? letter_guess
        # else
        #     @chances = @chances - 1
        # end
    end

    def guessed_letters_array(letter_guess)
        @guessed_letters << letter_guess
    end

    def correct_guesses_array(letter_guess)
        @correct_guesses << letter_guess
    end

    def blank_word_gets_filled_with_correct_guess(letter_guess)
        i = 0
        @word.length.times do
           if @word[i] == letter_guess
               @blank_word[i] = letter_guess
               @split_word.delete_at(i)
           end
           i += 1
        end
    end

    def secret_word_correct_guesses_removed_from_array(letter_guess)
        position_in_secret_word = @word.index(letter_guess)
        @split_word.delete_at(position_in_secret_word)
    end

    def combined_fill_and_delete(letter_guess)
        if word_include?(letter_guess)
            blank_word_gets_filled_with_correct_guess(letter_guess)
            secret_word_correct_guesses_removed_from_array(letter_guess)
        end
    end

    # def find_first_occurance_of_correct_letter_in_source_word(letter_guess)
    #     @position_in_secret_word = @word.index(letter_guess)
    # end

    def no_empty_strings_left?(blank_word)
        if @blank_word.include?("_")
            false
        else
            true
        end
    end

    def already_guessed(letter_guess)
        @blank_word.include? letter_guess
    end

    def game_over?(correct_guesses, guessed_letters)
        if guessed_letters.length + 5 >= correct_guesses.length
            true
        end
    end

    def too_many_guesses?
        if chances >= 7
            true
        end
    end

    def counter
        @chances = chances + 1
    end

    def begin_game
        play_game until no_empty_strings_left? || game_over?
    end

    def word_included(letter_guess)
        blank_word_gets_filled_with_correct_guess(letter_guess)
        # secret_word_correct_guesses_removed_from_array(letter_guess)
    end

    def guess(letter_guess)
        # until @chances == 0
        if @chances >= 7
            too_many_guesses?
        elsif @word.include? letter_guess
            input_secret_word
            # find_first_occurance_of_correct_letter_in_source_word(letter_guess)
            word_included(letter_guess)
            guessed_letters_array(letter_guess)
            correct_guesses_array(letter_guess)
        else
            guessed_letters_array(letter_guess)
            counter
        end
    end

def write_to_csv(player_2_name, keyword)
        CSV.open("file.csv", "a") do |row|
                row << [@player_name, @player_word]
        end
end
def play_game #this calls all of the other function to run the game
        input_secret_word
        begin_game
        guess
        write_to_csv
end    

end
