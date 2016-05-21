require 'io/console'
require_relative 'player'
require_relative 'colorize_strings'

class Game
  attr_reader :over
  @@screen_width = IO.console.winsize[1]

  def initialize
    @pegs = Array.new(6)
    (0..6).each { |i| @pegs[i] = i.to_s.colorize(30 + i) }
    @turns = 12
    @over = false
    new_board
  end

  def new_board
    @sq = Array.new(5)
    @sq[0] = @p2_mark # this fills position 0
    (1..4).each { |i| @sq[i] = i }
  end

  def print_board
    puts " #{@pegs[1]} | #{@pegs[2]} | #{@pegs[3]} "
    puts " #{@pegs[4]} | #{@pegs[5]} | #{@pegs[6]} "
  end
end

module Mastermind
  @@screen_width = IO.console.winsize[1]

  def self.header
    system 'clear' or system 'cls'
    puts "Mastermind\n".center(@@screen_width)
    msg = "(Hit CTRL+C at any time to exit the program)\n\n"
    puts msg.center(@@screen_width)
  end

  def self.start
    correct_answer = false
    until correct_answer
      header
      puts "Welcome to Mastermind.\n"
      puts 'Do you want to play? (Write Y or N):'
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

  def self.new_game
    p1 = Player.new
    game = Game.new
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

Mastermind.start
