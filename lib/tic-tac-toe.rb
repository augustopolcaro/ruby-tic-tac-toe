require "./lib/winning-conditions.rb"
require "./lib/auxiliar.rb"

class Player
  include Auxiliar
  attr_accessor :piece, :name

  def initialize(name, piece, type = "Human")
    @name = name
    @piece = piece
    @type = type
  end

  def won?(board)
    WINNING_CONDITIONS.each do |elem|
      if (board[elem[0]][0] == @piece &&
          board[elem[1]][0] == @piece &&
          board[elem[2]][0] == @piece)
        return true
      end
    end
    return false
  end

  def move
    puts "#{@name} make your move:"
    move = getMove
    return move
  end
end

class Robot < Player
  def move
    letters = ["a", "b", "c"]
    numbers = ["1", "2", "3"]
    move = letters[rand(0..2)] + numbers[rand(0..2)]
    return move
  end
end

class Game
  include Auxiliar

  @@gamesPlayed = 0

  def initialize
    @board = Array.new(9, "-")
    @turn = "X"
  end

  def self.start
    game = Game.new
    welcome
    again = true
    type = game.select_type_of_game
    game.select_players(type)
    while (again)
      loop do
        game.play
        if (!game.playing?)
          break
        end
      end
      again = game.want_to_play_again?
    end
  end

  def want_to_play_again?
    puts "Do you want to play again? Y / N"
    answer = gets.chomp
    if (answer.upcase == "Y")
      reset_board
      swap_pieces
      return true
    else
      return false
    end
  end

  def reset_board
    @turn = "X"
    @board = Array.new(9, "-")
  end

  def swap_pieces
    aux = @playerOne.piece
    @playerOne.piece = @playerTwo.piece
    @playerTwo.piece = aux
  end

  def show_board
    puts `clear`
    puts "   a     b     c"
    puts "      |     |     "
    puts "1  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  "
    puts " _____|_____|_____"
    puts "      |     |     "
    puts "2  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  "
    puts " _____|_____|_____"
    puts "      |     |     "
    puts "3  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  "
    puts "      |     |     "
  end

  def select_type_of_game
    puts "1- Player vs Player"
    puts "2- Player vs Computer"
    option = getOption("1", "2")
    return option
  end

  def self.welcome
    puts "Welcome to Tic Tac Toe game"
    puts "Select an Option and press Enter:"
  end

  def select_players(type)
    if (type == "1")
      puts "Player One enter your name"
      @playerOne = Player.new(getName, "X")
      puts "Player Two enter your name"
      @playerTwo = Player.new(getName, "O")
    else
      puts "Player One enter your name"
      @playerOne = Player.new(getName, "X")
      @playerTwo = Robot.new("Robotito", "O")
    end
  end

  def play
    show_board
    move
  end

  def playing?
    if (@playerOne.won?(@board))
      show_board
      puts "Congratz #{@playerOne.name} you won!"
      return false
    end
    if (@playerTwo.won?(@board))
      show_board
      puts "Congratz #{@playerTwo.name} you won!"
      return false
    end
    if (board_is_full?)
      puts "Oops, is a Draw!"
      return false
    end
    return true
  end

  def board_is_full?
    @board.each do |space|
      if space == "-"
        return false
      end
    end
    return true
  end

  def move
    if (@playerOne.piece == @turn)
      move = @playerOne.move
      while !check_move(move, @board)
        move = @playerOne.move
      end
      write_board(move, @playerOne.piece)
      swapTurn
    else
      move = @playerTwo.move
      while !check_move(move, @board)
        move = @playerTwo.move
      end
      write_board(move, @playerTwo.piece)
      swapTurn
    end
  end

  def swapTurn
    if @turn == "X"
      @turn = "O"
    else
      @turn = "X"
    end
  end

  def write_board(move, piece)
    moves = { :a1 => 0, :b1 => 1, :c1 => 2, :a2 => 3, :b2 => 4, :c2 => 5,
              :a3 => 6, :b3 => 7, :c3 => 8 }
    @board[moves[move.to_sym]] = piece
  end

  def check_move(move, board)
    moves = { :a1 => 0, :b1 => 1, :c1 => 2, :a2 => 3, :b2 => 4, :c2 => 5,
              :a3 => 6, :b3 => 7, :c3 => 8 }
    if (board[moves[move.to_sym]] == "-")
      return true
    else
      puts "Please select an empty square"
      return false
    end
  end
end

Game.start
