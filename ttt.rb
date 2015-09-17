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
    break if ["X", "O"].include?(letter)
    puts "You can only select 'X' or 'O' as valid game pieces"
  end
  letter
end

def build_board(b)
  puts "     |     |     "
  puts "  #{b[1]}  |  #{b[2]}  |  #{b[3]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{b[4]}  |  #{b[5]}  |  #{b[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{b[7]}  |  #{b[8]}  |  #{b[9]}  "
  puts "     |     |     "
end

def player_move(b, letter)
  begin
    puts "Specify the number on the board to begin"
    player_input = 0
    loop do
      player_input = gets.chomp.to_i
      break if (1..9).include?(player_input)
      puts "Number must be between 1 - 9"
    end
    if tile_already_played?(b, player_input)
      b[player_input] = letter
    else
      puts "Tile already played, please select a different tile"
    end
  end until !tile_already_played?(b, player_input)
end

def computer_move(b, letter)
  computer_input = b.select { |k, v| (1..9).include?(v) }.keys.sample
  b[computer_input] = letter
end

def tile_already_played?(b, number)
  (1..9).include?(b[number]) ? true : false
end

puts "Welcome to Tic, Tac, Toe!"
puts "What is your name?"
user_name = gets.chomp.capitalize

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
    puts
    puts "Computer is thinking......"
    puts
    sleep 3.0
    computer_move(board, computer_letter)
    build_board(board)
    puts
  end until false

end