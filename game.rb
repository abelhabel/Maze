# 13 errors in rubocop
require './player.rb'
require './level.rb'
require './print.rb'
require './parse.rb'
require 'io/console'

def read_char
  STDIN.echo = false
  STDIN.raw!
 
  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!
 
  return input
end

def read_single_key
  c = read_char
 
  case c
  when "\u0003"
    puts "CONTROL-C"
    exit 0
  when "h"
    return 'help'
  when "q"
    return 'quit'
  when "i"
    return 'inventory'
  when "\e[A"
    puts "UP"
    return 'up'
  when "\e[B"
    puts "DOWN"
    return 'down'
  when "\e[C"
    puts "RIGHT"
    return 'right'
  when "\e[D"
    puts "LEFT"
    return 'left'
  else
    return 'No valid input'
  end
end

class Game

  attr_reader :level
  attr_reader :start_pos
  
  def initialize(player)
    @player = player
    @current_layer = 0
    @level = Level.new(0)
  end
  
  def calculate_score
    [0, (100 - @player.steps) + (10 * @player.treasures)].max
  end

  def update_player_position!
    @player.position = @level.current_pos
  end

  def game_loop!
    remain = true
    update_player_position!
    puts "Welcome to The Maze, #{@player.user_name}."
    puts 'The square below shows you the immediate tiles to the North, South, West and East.'
    puts "At any time, type 'h' or 'help' to see what the characters mean and to see input controls."
    while remain
      Print.view(@level.get_adjacent_tiles(@player.position[:x], @player.position[:y]))
      input = read_single_key
      remain = Parser.parse(input, @player, @level)
    end
  end
end
