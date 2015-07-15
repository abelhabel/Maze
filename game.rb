# 13 errors in rubocop
require './player.rb'
require './level.rb'
require './print.rb'
require './parse.rb'
class Game

  attr_reader :level
  attr_reader :start_pos
  
  def initialize(player_name)
    @player = Player.new(player_name, {})
    @current_layer = 0
    @level = Level.new(0)
  end
  
  def update_player_position!
    @player.position = @level.current_pos
  end

  def game_loop!
    remain = true
    update_player_position!
    puts "Welcome to The Maze, #{@player.name}."
    puts 'The square below shows you the immediate tiles to the North, South, West and East.'
    puts "At any time, type 'h' or 'help' to see what the characters mean and to see input controls."
    while remain
      Print.view(@level.get_adjacent_tiles(@player.position[:x], @player.position[:y]))
      input = gets.chomp
      remain = Parser.parse(input, @player, @level)
    end
  end
end
