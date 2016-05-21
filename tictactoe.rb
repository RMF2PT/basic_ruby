require 'io/console'
require_relative 'player'

class Game
  @@screen_width = IO.console.winsize[1]
  attr_reader :p1_id, :p2_id, :over
  LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
           [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @p1_mark = 'X'
    @p1_id = "Player 1: #{p1.player_name} => #{@p1_mark[0]}"
    @p2_mark = 'O'
    @p2_id = "#{@p2_mark[0]} <= Player 2: #{p2.player_name}"
    @over = false
    @win = 0
    new_board
  end

  def next_move(player)
    check_winning_condition
    if player.is_computer
      puts "\nComputer thinking..."
      computer_move
    else
      puts "\n#{player.player_name}, where do you want to play?"
      position = gets.chomp.strip.to_i
      if position.is_a?(Integer) && position.between?(1, 9) &&
         square_empty?(position)
        @sq[position] = player == @p1 ? @p1_mark : @p2_mark
      else
        position_invalid
        next_move(player)
      end
    end
  end

  def computer_move
    th1 = Thread.new { 9.times { sleep 0.5; print '.' } }
    th2 = Thread.new do
      position = 5
      position = Random.rand(1..9).to_i until square_empty?(position)
      @sq[position] = @p2_mark
    end
    th1.join
    th2.join
  end

  def new_board
    @sq = Array.new(10)
    @sq[0] = @p2_mark # this fills position 0
    (1..9).each { |i| @sq[i] = i }
  end

  def print_board
    puts  @p1_id.to_s.center(@@screen_width / 2) +
          @p2_id.to_s.center(@@screen_width / 2)
    puts " #{@sq[1]} | #{@sq[2]} | #{@sq[3]} ".center(@@screen_width)
    puts ' --+---+-- '.center(@@screen_width)
    puts " #{@sq[4]} | #{@sq[5]} | #{@sq[6]} ".center(@@screen_width)
    puts ' --+---+-- '.center(@@screen_width)
    puts " #{@sq[7]} | #{@sq[8]} | #{@sq[9]} ".center(@@screen_width)
  end

  def square_empty?(position)
    @sq[position] != @p1_mark && @sq[position] != @p2_mark
  end

  def position_invalid
    puts 'That position is invalid. Please try another.'
    sleep 1
    TicTacToe.header
    print_board
  end

  def check_winning_condition
    LINES.each do |line|
      @win = 1 if line.all? do |position|
        @sq[position] == @p1_mark
      end
      @win = 2 if line.all? do |position|
        @sq[position] == @p2_mark
      end
    end
    game_over unless @win == 0
    game_over if @sq.none? { |pos| square_empty?(pos.to_i) }
  end

  def game_over
    puts "\nThe game is over."
    if @win == 1
      puts "#{@p1.player_name} wins!"
    elsif @win == 2
      puts "#{@p2.player_name} wins!"
    else
      puts "It's a draw!"
    end
    puts 'Thank you for playing!'
    exit
  end
end

module TicTacToe
  @@screen_width = IO.console.winsize[1]

  def self.header
    system 'clear' or system 'cls'
    puts "TIC TAC TOE\n".center(@@screen_width)
    msg = "(Hit CTRL+C at any time to exit the program.)\n\n"
    puts msg.center(@@screen_width)
  end

  def self.start
    header
    puts "Welcome to TIC TAC TOE, the newest and coolest game in town.\n"
    puts 'Do you want to play? (Y/N):'
    answer = gets.chomp.strip.downcase

    correct_answer = answer == 'y' || answer == 'n' ? true : false
    until correct_answer
      header
      puts 'Wrong answer. Do you want to play? (Write Y or N):'
      answer = gets.chomp.strip.downcase
      correct_answer = true if answer == 'y' || answer == 'n'
    end

    if answer == 'y'
      new_game
    else
      header
      puts 'Thank you! Please come back again.'
      exit
    end
  end

  def self.number_of_players
    n_players = 0
    until n_players.between?(1, 2)
      puts 'How many human players? (1/2):'
      n_players = gets.chomp.strip.to_i
      header
    end
    n_players
  end

  def self.new_game
    n_players = number_of_players
    p1 = Player.new
    header
    p2 = n_players == 1 ? ComputerPlayer.new : Player.new
    header
    first_player = Random.rand(2).to_i
    if first_player == 1
      puts "#{p1.player_name} plays first!"
      second_player = 2
    else
      puts "#{p2.player_name} plays first!"
      second_player = 1
    end
    sleep 2
    game = Game.new(p1, p2)
    until game.over
      header
      game.print_board
      if first_player == 1
        game.next_move(p1)
      else
        game.next_move(p2)
      end
      # change player turn
      first_player, second_player = second_player, first_player
    end
  end
end

TicTacToe.start
