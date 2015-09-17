puts "Welcome to Tic, Tac, Toe!"

def get_player_letter
  puts "Would you like to be X's or O's? (X/O)"
  loop do
    letter = gets.chomp.upcase
    break if ["X", "O"].include?(letter)
  end
end

def build_board(position = nil, player_letter = nil)
  positions = { one: "1", two: "2", three: "3", four: "4", five: "5", 
              six: "6", seven: "7", eight: "8", nine: "9" }

  positions[position] = player_letter

  puts "     |     |     "
  puts "  #{positions[:one]}  |  #{positions[:two]}  |  #{positions[:three]}   "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{positions[:four]}  |  #{positions[:five]}  |  #{positions[:six]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{positions[:seven]}  |  #{positions[:eight]}  |  #{positions[:nine]}  "
  puts "     |     |     "
end

player_letter = get_player_letter
puts "Okay, you will be #{player_letter}"
puts "You have first move! Specify the number on the board to begin."
build_board

first_move = gets.chomp
build_board(first_move, "X")