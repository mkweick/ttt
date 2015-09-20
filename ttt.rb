WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9],
                 [3,5,7]]
#
def new_game_board
    positions = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 
                  7 => 7, 8 => 8, 9 => 9 }
    positions
end

def get_player_letter
  puts "Would you like to be X's or O's? (X/O)"
  letter = ""
  loop do
    letter = gets.chomp.upcase
    break if %w(X O).include? letter
    puts "You can only select 'X' or 'O' as valid game pieces"
  end
  letter
end

def build_board(board)
  system "clear"
  puts "     |     |     "
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "     |     |     "
end

def player_move(board, letter)
  player_input = valid_tile?(board)
  board[player_input] = letter
end

def valid_tile?(board)
  puts "Your turn, select a tile:"
  player_input = gets.chomp.to_i
  loop do
    tile_valid = tile_one_thru_nine?(player_input)
    unplayed_tile = tile_already_played?(board, player_input)
    break if tile_valid && unplayed_tile
    puts "Tile #{player_input} is not between 1-9 or has already been played."
    puts "Please enter a valid tile number:"
    player_input = gets.chomp.to_i
  end
    player_input
end

def tile_one_thru_nine?(tile)
  (1..9).any? { |number| number == tile }
end

def tile_already_played?(board, tile)
  %w(X O).none? { |letter| letter == board[tile] }
end

def computer_move(board, player_letter, computer_letter)
  # Check 2 in a row for computer character
  if WINNING_LINES.any? { |two| board.values_at(*two).count(computer_letter) == 2 }
    check_for_computer_two_in_row(board, player_letter, computer_letter)
  # Check 2 in a row for player character
  elsif WINNING_LINES.any? { |two| board.values_at(*two).count(player_letter) == 2 }
    check_for_player_two_in_row(board, player_letter, computer_letter)
  else
    assign_random_computer_tile(board, computer_letter)
  end
end

# Check if computer can win
def check_for_computer_two_in_row(board, player_letter, computer_letter)
  two_in_row = WINNING_LINES.select do |two| 
    board.values_at(*two).count(computer_letter) == 2
  end
  two_in_row_open = two_in_row.select do |two| 
    two.none? do |number| 
      board.values_at(number).include? player_letter
    end
  end
  if two_in_row_open.empty?
    check_for_player_two_in_row(board, player_letter, computer_letter)
  else
    two_in_row_final = two_in_row_open.first
    comp_tile_number = two_in_row_final.select { |tile| (1..9).include? board[tile] }
    computer_input = comp_tile_number.first
    board[computer_input] = computer_letter
  end
end

# Check if player can win
def check_for_player_two_in_row(board, player_letter, computer_letter)
  two_in_row = WINNING_LINES.select do |two| 
    board.values_at(*two).count(player_letter) == 2
  end
  two_in_row_open = two_in_row.select do |two| 
    two.none? do |number| 
      board.values_at(number).include? computer_letter
    end
  end
  if two_in_row_open.empty?
    assign_random_computer_tile(board, computer_letter)
  else
    two_in_row_final = two_in_row_open.first
    comp_tile_number = two_in_row_final.select { |tile| (1..9).include? board[tile] }
    computer_input = comp_tile_number.first
    board[computer_input] = computer_letter
  end
end

def assign_random_computer_tile(board, computer_letter)
  computer_input = board.select { |k, v| (1..9).include? v }.keys.sample
  board[computer_input] = computer_letter
end

def open_tiles?(board)
  board.values.any? { |number| (1..9).include? number }
end

def check_winner(board, player_letter, computer_letter, user_name)
  WINNING_LINES.each do |line|
    return user_name if board.values_at(*line).count(player_letter) == 3
    return "Computer" if board.values_at(*line).count(computer_letter) == 3
  end
  nil
end

def announce_winner(winner)
  puts "#{winner} won!"
end

puts "Welcome to Tic, Tac, Toe!"
puts "What is your name?"
user_name = gets.chomp.capitalize

# Start Game Loop
loop do
  player_letter = get_player_letter
  player_letter == "X" ? computer_letter = "O" : computer_letter = "X"
  puts "#{user_name}, you will be #{player_letter}'s."
  puts
  board = new_game_board
  build_board(board)
  puts
  puts "You have first move!"
  
  begin
    player_move(board, player_letter)
    build_board(board)
    winner = check_winner(board, player_letter, computer_letter, user_name)
    if open_tiles?(board) && winner.nil?
      puts "Computer is thinking......"
      sleep 3.0
      computer_move(board, player_letter, computer_letter)
      build_board(board)
      winner = check_winner(board, player_letter, computer_letter, user_name)
      announce_winner(winner) if winner
    elsif winner
      announce_winner(winner)
    else
      puts "It's a tie."
    end
  end until !open_tiles?(board) || winner

  # Play again?
  begin
    puts "Do you want to play again? (Y/N)"
    play_again = gets.chomp.upcase
  end until %w(Y N).any? { |letter| letter == play_again }
  break if play_again == "N"
end