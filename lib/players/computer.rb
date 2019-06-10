
module Players

  class Computer < Player

    def move(board)
      empty_spaces=[]
      board.cells.each.with_index(1){|i, index| empty_spaces << index if i == " "}
      empty_spaces.sample.to_s
    end

  end

end
