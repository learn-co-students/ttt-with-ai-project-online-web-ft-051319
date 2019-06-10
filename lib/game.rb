require "pry"

class Game

  attr_accessor :board, :player_1, :player_2

  def initialize(player_1=Players::Human.new("X"),player_2=Players::Human.new("O"),board=Board.new)
    @board=board
    @player_1=player_1
    @player_2=player_2
  end

  WIN_COMBINATIONS= [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]

  def current_player
    (@board.turn_count+1).odd? ? @player_1 : @player_2
  end

  def won?
    @x=[]
    @o=[]
    @board.cells.each_with_index do |a,i|
      if a=="X"
        @x << i #creating array of X indices
      elsif a =="O"
        @o << i #creating array for O indices
      end
    end
    resultx=WIN_COMBINATIONS.map{|i| (i-@x).empty?}
    #this creates an array of true or false to see if all elements in each winning array in our WIN_COMBINATIONS
    #constant is present in our X indices
    #https://stackoverflow.com/questions/7387937/how-to-determine-if-one-array-contains-all-elements-of-another-array
    resulto=WIN_COMBINATIONS.map{|i| (i-@o).empty?}
    #doing the same for the O's
    @winning_combi=[]
    if resultx.any?
      @winning_combi=WIN_COMBINATIONS[resultx.index(true)]
      @winning_combi
    elsif resulto.any?
      @winning_combi=WIN_COMBINATIONS[resulto.index(true)]
      @winning_combi
    else
      false
    end
  end


  def full?
    @board.cells.any?(" ")? false : true
  end

  def draw?
    if won? || (full?) == false
      false
    elsif won? ==false && (full?)==true
      true
    else
      true
    end
  end

  def over?
    if draw? || won?
      true
    else
      false
    end
  end

  def winner
    if draw?
      nil
    elsif won?
      ((@winning_combi-@x).empty?)? "X" : "O"
      #if x contains all the winning_combi indices then X is the winner, otherwise it's O
    else
      nil
    end
  end

  def turn
    input=current_player.move(@board)
    while @board.valid_move?(input) == false
      puts "invalid"
      input=current_player.move(@board)
    end
    board.update(input,current_player)
  end

  def play
    while (over?) == false
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

end
