module Auxiliar
  def getOption(a, b)
    choice = gets.chomp
    while choice != a && choice != b
      puts "Please choose [#{a}] or [#{b}]"
      choice = gets.chomp
    end
    return choice
  end

  def getName
    name = gets.chomp
    while name == ""
      puts "You can't leave your name blank"
      name = gets.chomp
    end
    return name
  end

  def getMove
    valid_moves = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]
    move = gets.chomp
    while !valid_moves.include?(move)
      puts "Invalid move, try again, example: a1"
      move = gets.chomp
    end
    return move
  end
end
