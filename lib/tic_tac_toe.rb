require 'pry'
class TicTacToe
    attr_reader :board

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token)
        board[index] = token
    end

    def position_taken?(position)
        # board[index] == "X" || board[index] == "O"
        board[position] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0, 8)
    end

    def turn_count
        (board - [" "]).length
        # board.count {|square| square != " "}
    end

    def current_player
        turn_count.odd? ? "O" : "X"
    end

    def turn
        user_input = gets.strip
        user_index = input_to_index(user_input)
        if valid_move?(user_index) 
            move(user_index, current_player) 
        else
            puts "The current move is not valid! Please try another position."
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]] && position_taken?(win_combo[0])
        end
    end

    def full?
        turn_count == 9
    end

    def draw?
        !won? && full?
    end

    def over?
        draw? || won?
    end

    def winner
        if winning_combo = won?
            board[winning_combo[1]]
        end
    end

    def play 
        turn until over?
        puts won? ? "Congratulations #{winner}!" :  "Cat's Game!"
    end

end