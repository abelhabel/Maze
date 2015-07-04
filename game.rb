# 13 errors in rubocop
require './player.rb'
require './level.rb'
require './print.rb'
class Game
  def initialize(player_name)
    @player = Player.new(player_name, {})
    @current_layer = 0
    @level = Level.new(0)
  end
  attr_reader :level
  attr_reader :start_pos
  def update_player_position!
    @player.position = @level.current_pos
  end

  private

  def parse!(text)
    north = 'n'
    south = 's'
    west = 'w'
    east = 'e'
    help = /h|help/
    quit = /q|quit/
    inventory = /i|inventory/

    dirx = 0
    diry = 0

    if text[north]
      diry = - 1
    elsif text[south]
      diry = 1
    elsif text[west]
      dirx = - 1
    elsif text[east]
      dirx = 1
    end

    if dirx != 0 || diry != 0
      @level.set_tile!(@player.position[:x], @player.position[:y], '-')
      tile = @level.get_tile(@player.position[:x] + dirx, @player.position[:y] + diry)
      if tile.match(/[-EK]/)
        @player.move!(dirx, diry)
        if tile == 'E'
          puts 'You found the exit!'
          if @level.next_level!
            update_player_position!
            puts 'However, all you found was a new maze! The horror!'
          else
            puts 'Congratulations to completing the game.'
            puts 'Credits'
            puts 'Programming: Andreas Olsson'
            puts 'Design: Andreas Olsson'
            puts 'Graphics: Andreas Olsson'
            puts 'A/V-FX: Jorv Xerxor'
            return false
          end
        end
        if tile == 'K'
          puts 'You found a key!'
          @player.add_key!(1)
        end
      else
        if tile == 'D'
          if @player.keys <= 0
            puts 'You need a key to get through that door!'
          else
            puts 'You unlocked the door with a key!'
            @player.move!(dirx, diry)
            @player.add_key!(-1)
          end
        else
          puts 'Cannot move there!'
        end
      end
    end
    
    if text[help]
      Print.help
    elsif text[inventory]
      @player.print_inventory
    elsif text[quit]
      return false
    end
      
    true
  end

  public

  def game_loop!
    remain = true
    update_player_position!
    puts "Welcome to The Maze, #{@player.name}."
    puts 'The square below shows you the immediate tiles to the North, South, West and East.'
    puts "At any time, type 'h' or 'help' to see what the characters mean and to see input controls."
    while remain
      Print.view(@level.get_adjacent_tiles(@player.position[:x], @player.position[:y]))
      input = gets.chomp
      remain = parse!(input)
    end
  end
end
