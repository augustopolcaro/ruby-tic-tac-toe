require "./lib/tic-tac-toe.rb"

describe Player do
  describe "#won?" do
    it "check if the player one have won" do
      p1 = Player.new("Augusto", "X")
      board = [["X"], ["-"], ["-"],
               ["-"], ["X"], ["-"],
               ["O"], ["0"], ["X"]]
      expect(p1.won?(board)).to eql(true)
    end

    it "check if the player one didnt won" do
      p1 = Player.new("Augusto", "X")
      board = [["X"], ["-"], ["-"],
               ["-"], ["X"], ["-"],
               ["O"], ["O"], ["O"]]
      expect(p1.won?(board)).to eql(false)
    end

    it "check if the player one won with O piece" do
      p1 = Player.new("Augusto", "O")
      board = [["X"], ["-"], ["-"],
               ["-"], ["X"], ["-"],
               ["O"], ["O"], ["O"]]
      expect(p1.won?(board)).to eql(true)
    end

    it "check if the player one didnt won with O piece" do
      p1 = Player.new("Augusto", "O")
      board = [["X"], ["O"], ["X"],
               ["X"], ["X"], ["O"],
               ["O"], ["O"], ["X"]]
      expect(p1.won?(board)).to eql(false)
    end
  end
end
