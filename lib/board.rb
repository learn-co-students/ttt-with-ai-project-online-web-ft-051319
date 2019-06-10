 class Board
   attr_accessor :cells

   def initialize
     reset!
   end

   def reset!
     @cells=Array.new(9, " ")
   end

   def display
     puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
     puts "-----------"
     puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
     puts "-----------"
     puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
   end

   def position(input)
     @cells[input.to_i-1]
   end

   def full?
     @cells.include?(" ") ? false : true
   end

   def turn_count
     9-@cells.count(" ")
   end

   def taken?(input)
     if @cells[input.to_i-1]=="X" || @cells[input.to_i-1]=="O"
       true
     else
       false
     end
   end

   def valid_move?(input)
     if taken?(input)==false && (1..9).to_a.include?(input.to_i)
       true
     else
       false
     end
   end

   def update(position,player)
     @cells[position.to_i-1]=player.token
   end

 end
