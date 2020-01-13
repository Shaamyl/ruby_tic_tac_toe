class GameBoard
  attr_reader :board_matrix, :has_ended

  def initialize
    @board_matrix = [[".",".","."],[".", ".", "."],[".", ".", "."]]
    @has_ended = false
  end

  def update_board_position x, y, char
    return "error" unless @board_matrix[x][y] == "."
    @board_matrix[x][y] = char if @board_matrix[x][y] == "."
  end

  def check_ended char
    counter3 = 0
    0.upto(2) do |x|
      counter = 0
      counter2 = 0
      0.upto(2) do |y|
        counter += 1 if @board_matrix[x][y] == char
        counter2 += 1 if @board_matrix[y][x] == char
        counter3 += 1 if @board_matrix[x][y] != "."
      end
      @has_ended = true if counter == 3 or counter2 == 3
      return char if counter == 3 or counter2 == 3
    end

    #diagonal1
    @has_ended = true if @board_matrix[0][0] == char and @board_matrix[1][1] == char and @board_matrix[2][2] == char
    return char if @board_matrix[0][0] == char and @board_matrix[1][1] == char and @board_matrix[2][2] == char
    #diagonal2
    @has_ended = true if @board_matrix[0][2] == char and @board_matrix[1][1] == char and @board_matrix[2][0] == char
    return char if @board_matrix[0][2] == char and @board_matrix[1][1] == char and @board_matrix[2][0] == char
    #draw
    @has_ended = true if counter3 == 9
    return "." if counter3 == 9

    false
  end
end

class Player
  attr_accessor :game_char

  def initialize(game_char: )
    @game_char = game_char
  end

  def make_move(game_board, x, y)
    game_board.update_board_position x, y, @game_char
  end
end

class TicTacToe
  def initialize
    @p1 = Player.new(game_char: "O")
    @p2 = Player.new(game_char: "X")
    @game_board = GameBoard.new
    @p1_turn = true
  end

  def run
    until @game_board.has_ended
      puts
      puts "Enter move in the form r, c where r = row and c = column"
      puts
      show_board
      puts
      if @p1_turn
        puts "Enter move, player 1 (O)"
        input = gets.chomp
        x, y = input.split(",")
        result = @p1.make_move @game_board, x.strip.to_i, y.strip.to_i
        next if result == "error"
        @p1_turn = false
      else
        puts "Enter move, player 2 (X)"
        input = gets.chomp
        x, y = input.split(",")
        result = @p2.make_move @game_board, x.strip.to_i, y.strip.to_i
        next if result == "error"
        @p1_turn = true
      end
      result1 = @game_board.check_ended @p1.game_char
      result2 = @game_board.check_ended @p2.game_char
      if result1 == "O"
        puts
        show_board
        puts
        puts "Player 1 (O) wins!"
      elsif result2 == "X"
        puts
        show_board
        puts
        puts "Player 2 (X) wins!"
      elsif result1 == "."
        puts
        show_board
        puts
        puts "It's a draw :("
      end
    end
  end

  private
  def show_board
    board_matrix = @game_board.board_matrix
    board_matrix.each do |row|
      row.each do |position|
        print position + " "
      end
      puts ""
    end
  end
end

game = TicTacToe.new
game.run
