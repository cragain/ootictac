# 1) Make board from 2 vert and 2 horizontal lines, each space should be a unique location.
# 2) Players- One is human, one is a computer.  Human goes first and will be X, computer second as is O
# 3) Play continues until a player gets 3 vertical, 3 horizontal, or 3 diagonal blocks
# 4) if not winners, game is over if all squares have been played
# 5) Offer to play again

require 'pry'

class Board
 
  def initialize
    @boarddata = {}
    (1..9).each{|position| @boarddata[position] = Square.new('')}
  end

  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,5,9], [1,5,9], [3,5,7]]
  
  def winning_set(marker)
    WINNING_LINES.each do |line|
      return true if @boarddata[line[0]].value == marker && @boarddata[line[1]].value == marker && @boarddata[line[2]].value == marker
    end
    false
  end
  
  def draw
    system 'clear'
    puts
    puts "   #{@boarddata[1].value} | #{@boarddata[2].value} | #{@boarddata[3].value} "
    puts "------------"
    puts "   #{@boarddata[4].value} | #{@boarddata[5].value} | #{@boarddata[6].value} "
    puts "------------"
    puts "   #{@boarddata[7].value} | #{@boarddata[8].value} | #{@boarddata[9].value} "
    puts
  end
  
  def empty_spaces
    @boarddata.select {|k, s| s.value == ''}.values
  end
  
  def all_squares_marked
    empty_spaces.size == 0
  end
  
  def mark_square(position, marker)
    @boarddata[position].mark(marker)
  end
  
  def empty_positions
    @boarddata.select {|_, square| square.empty?}.keys
  end
end

class Square
  attr_reader :value

  def initialize(value)
    @value = value
  end
  
  def mark(marker)
    @value = marker
  end
  
  def empty?
    @value == ''
  end
end

class Player
  attr_reader :name, :marker
  
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
 
  def initialize
    @board = Board.new
    @chris = Player.new("Chris", "X")
    @computer = Player.new("Megatron", "O")
    @current_player = @chris
  end
  
  def current_player_takes_turn
    if @current_player == @chris
      begin
        puts "Choose a position #{@board.empty_positions}"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end
  
  def current_player_win?
    @board.winning_set(@current_player.marker)
  end
  
  def alternate_player
    if @current_player == @chris
      @current_player = @computer
    else
      @current_player = @chris
    end
  end
  
  def play
    @board.draw
    loop do
      current_player_takes_turn
      @board.draw
      if current_player_win?
        puts "And the winner is #{@current_player.name}"
        break
      elsif @board.all_squares_marked
        puts "Its a Tie"
      else
      alternate_player
      end
    end
  end
end
Game.new.play
