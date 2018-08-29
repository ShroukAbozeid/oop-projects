# colors orange yellow red purple blue green white black
# numbers 0 	1 		2	3		4	5	"white"	 "black"
class Player
	attr_reader :name
	def initialize(name)
	  @name = name
	end
end

class CodeMaker < Player
	def build_code(code=nil)
		if code.nil?
		  @code = Array.new(4) { |i|  i = rand(0..5) } 
		else
		  @code = code
		end
	end

	def give_feedback(guess,auto=true)
		if !auto
			puts "Enter feedback on computer guess , seperated by space"
			f = {"black" => "correct color and position", "white" => "correct color wrong position", "x" => "incorrect color"}
			f.each {|k,v| puts "#{k}: #{v}"}
			feedback = gets.chomp.split
		else
		  feedback = []
		  guess.each_with_index do |color, index|
		    if @code[index] == color
			  feedback << "black"
			elsif @code.include?color
				feedback << "white"
			else
				feedback << "x"
			end
		  end
		end
		feedback
	end
end

class CodeBreaker < Player
	attr_reader :correct_guess
	def initialize(name)
		super(name)
		@correct_guess = ["x", "x", "x", "x"]
	end

	def guess_code(guess=nil)
		if guess.nil?
		  @guess = Array.new(4) { |i|  i = rand(0..5) } 
		else
		  @guess = guess
		end
		for i in 0...4
		  if @correct_guess[i].is_a?Integer
			@guess[i] = @correct_guess[i]
		  end
		end
		@guess
	end

	def update_correct_guess(feedback)
		feedback.each_with_index do |val,index|
			if val == "black"
				@correct_guess[index] = @guess[index]
			end
		end
		@correct_guess
	end
end

class Game 
	def initialize
	  @colors = {orange:0, yellow:1, red:2, purple:3, blue:4, green:5 }
	end

	def setup
	  puts "Please Enter Your name "
	  name = gets.chomp
	  puts "What is your role? Enter 0 for Code Maker,  1 for Code Breaker "
	  while 1
	    @choice = gets.chomp.to_i
	    if @choice == 0
	      puts "Enter yout code".center(50,"-")
	  	  code = get_code
	  	  @maker = CodeMaker.new(name)
	  	  @maker.build_code(code)
	  	  @breaker = CodeBreaker.new("Computer")
	  	  break
	    elsif @choice == 1
	  	  @maker = CodeMaker.new("Computer")
	  	  @maker.build_code
	  	  @breaker = CodeBreaker.new(name)
	      break
	    else
	      puts "incorrect choice! Try Again"
	    end
	  end
	end
	
	def get_code
  	  puts "Enter 4 numbers seperated by space \n use numbers for colors as follows :"
  	  puts @colors
  	  code = gets.chomp
  	  code = code.split
  	  code.map!{|i| i.to_i }
	end

	def game_over?(iteration)
	  if !@breaker.correct_guess.include?"x"
	  	puts "Code Broken !"
	  	true
	  elsif iteration == 12
	  	puts "Game Over"
	  	true
	  else
	  	false
	  end	
	end

	def break_code
	  for i in 1..12
	 	if game_over?(i)
	 		break
	 	end
		if @choice == 1 
		  puts "Enter your guess".center(50,"-")
		  code = get_code
		else
			code = nil
		end
		guess = @breaker.guess_code(code)
		if @choice == 0
		  puts "Computer guess : #{guess}"
		  feedback = @maker.give_feedback(guess,false)
		else
		  feedback = @maker.give_feedback(guess)
		end
		puts "feedback: #{feedback}".center(50," ")
		cr = @breaker.update_correct_guess(feedback)
		puts "Correct guess so far #{cr}".center(50," ")
	  end
	end

	def mastermind
	  ##### GET INPUT
	  setup

	## BREAK CODE
	  break_code
	end
end



