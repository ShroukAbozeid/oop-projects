class Player
	attr_reader :name, :char
	def initialize(name, char)
		@name = name
		@char = char
	end
end

class Game

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@players = [player1, player2]
		@board = [["e","e","e"],["e","e","e"],["e","e","e"] ]
		@turn = 1
	end

	def flip_turn
		@turn == 1? @turn = 2 : @turn = 1
	end


	def same?(arr)
		arr[0] == arr[1] && arr[1] == arr[2] && arr[0] != "e"
	end

	def check_winner
		#check rows
		for row in @board
			if same?(row)
				return row[0]
			end
		end
		# check cols
		for i in 0...3
			col = [@board[0][i], @board[1][i], @board[2][i]]
			if same?(col)
				return col[0]
			end
		end
		# check diagonals
		diag = [@board[0][0], @board[1][1], @board[2][2]]
		diag2 = [@board[0][2], @board[1][1], @board[2][0]]
		if same?(diag)
			return diag[0]
		elsif same?(diag2)
			return diag2[0]
		else
			return "No"
		end
	end

	def game_over?
		if check_winner == "No" && !@board.flatten.include?("e") 
			return true
		end
		false
	end

	def draw_board(board=true)
		if !board 
			arr = [["1","2","3"],["4","5","6"],["7","8","9"]]
		else
			arr = @board
		end
		for row in arr
			print "| "
			for cell in row
				print cell+ " |"
			end
			puts "\n"
		end
	end

	def choose_postion
		draw_board(false)
		puts "Choose an empty postion to play according to the numbers above and to the board below"
		draw_board
		puts "\n"
		position  = gets.chomp.to_i
	end
	def pos_to_index(p)
		case p
		when 1 then return [0,0]
		when 2 then return [0,1]
		when 3 then return [0,2]
		when 4 then return [1,0]
		when 5 then return [1,1]
		when 6 then return [1,2]
		when 7 then return [2,0]
		when 8 then return [2,1]			
		when 9 then return [2,2]
		else return []
		end
	end

	def valid_position(arr)
	  @board[arr[0]][arr[1]] == "e"
	end

	def play
		while !game_over?
			puts "Player #{@players[@turn -1].name} Turn".center(70,"-")
			pos = choose_postion
			pos = pos_to_index(pos)
			while pos == [] || !valid_position(pos)
			  puts "Incorrect input Enter again".center(70,"!")
	    	  pos  = gets.chomp.to_i
	    	  pos = pos_to_index(pos)
			end
			@board[pos[0]][pos[1]] = @players[@turn -1].char
			draw_board
			flip_turn
		end
		flip_turn
		if check_winner != "No"
			puts "Player #{@players[@turn -1].name} WON!"
		else
			puts "It's a DRAW!"
		end
	end
end

def tic_tac_toc
	puts "Enter Player 1 Name : "
	name = gets.chomp
	player1 = Player.new(name,"X")
	puts "Enter Player2 Name:"
	name = gets.chomp
	player2 = Player.new(name,"O")
	game = Game.new(player1,player2)
	game.play
end

tic_tac_toc