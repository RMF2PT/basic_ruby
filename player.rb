class Player
  attr_reader :player_name, :is_computer
  @@players = 0

  def initialize
    @@players += 1
    puts "What's the name of player #{@@players}?"
    @player_name = gets.chomp.strip.capitalize
    @is_computer = false
  end
end

class ComputerPlayer < Player
  def initialize
    @player_name = 'Computer'
    @is_computer = true
  end
end
