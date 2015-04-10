# 1) Make board from 2 vert and 2 horizontal lines, each space should be a unique location.
# 2) Players- One is human, one is a computer.  Human goes first and will be X, computer second as is O
# 3) Play continues until a player gets 3 vertical, 3 horizontal, or 3 diagonal blocks
# 4) if not winners, game is over if all squares have been played
# 5) Offer to play again



class Board

  def initialize
    @boarddata = {}
    (1..9).each{|position| @boarddata[position] = Square.new('')}
  end
  
  def draw
    puts "Here comes your fresh board!......"
   
     
    puts "   #{@boarddata[1].value} | #{@boarddata[2].value} | #{@boarddata[3].value} "
    puts "------------"
    puts "   #{@boarddata[4].value} | #{@boarddata[5].value} | #{@boarddata[6].value} "
    puts "------------"
    puts "   #{@boarddata[7].value} | #{@boarddata[8].value} | #{@boarddata[9].value} "
  end
  
  def empty_spaces
    @boarddata.select {|k, s| s.value == ('')}.values
  end
  
  def all_squares_marked
    empty_spaces.size == 0
  end
  
  def mark_square(position, marker)
    @boarddata[position].mark(marker)
  end
  
  def empty_positions
    @boarddata.select {|k, s| !s.empty?}.keys
  end
end

class Square
  attr_accessor :value

  def initialize(value)
    @value = value
  end
  
  def mark(marker)
    @value = marker
  end
  
  def occupied?
    @value != ''
  end
  
  def empty?
    @value = ''
  end
end

class Player
  attr_accessor :name, :marker
  
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
  attr_accessor :human, :computer, :name
  
  def initialize
    @board = Board.new
    @chris = Player.new("Chris", "X")
    @computer = Player.new("Megatron", "O")
    @current_player = @human
  end
  
  def current_player_takes_turn
    if @current_player == @human
      begin
        puts "Choose a position 1-9"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end
  
  def alternate_player
    if @current_player == @human
        @current_player = @computer
    else
      @current_player = @human
    end
  end
  
  def play
    @board.draw
    loop do
      current_player_takes_turn
      alternate_player
      
    end
  end
end

Game.new.play
