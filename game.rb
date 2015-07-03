require './player.rb'
require './layers.rb'
require './logic.rb'
puts Helper.get_current_pos($layers[:tiles])
class Game
  @@start_pos = Helper.get_current_pos($layers[:tiles])
  def initialize(player_name)
    @player = Player.new(player_name, @@start_pos)
    @tile_layer = $layers[:tiles]
    @current_level = 0
  end
  attr_reader :start_pos
  def print_help
    puts "Use the keyboard to move. N=North, S=South, W=West, E=East"
    puts "# means that you cannot move there."
    puts "X is the edge of the maze."
    puts "D is a door."
    puts "K is a key."
    puts "E is the maze Exit and end goal."
  end

  def print_view
    left = Helper.get_tile(@tile_layer, @player.position[:x] -1, @player.position[:y])
    right = Helper.get_tile(@tile_layer, @player.position[:x] +1, @player.position[:y])
    up = Helper.get_tile(@tile_layer, @player.position[:x], @player.position[:y] -1)
    down = Helper.get_tile(@tile_layer, @player.position[:x], @player.position[:y] + 1)
    puts "---------"
    puts "|   #{up}   |"
    puts "| #{left}   #{right} |"
    puts "|   #{down}   |"
    puts "---------"
  end

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
      diry = -1
    elsif text[south]
      diry = 1
    elsif text[west]
      dirx = -1
    elsif text[east]
      dirx = 1
    end

    if dirx != 0 || diry != 0
      Helper.set_tile(@tile_layer, @player.position[:x], @player.position[:y], '-')
      tile = Helper.get_tile(@tile_layer, @player.position[:x] + dirx, @player.position[:y] + diry)
      if tile.match(/[-EK]/)
        @player.move(dirx, diry)
        if tile == 'E'
          puts "Congratulations! You found the exit!"
        end
        if tile == 'K'
          puts "You found a key!"
          @player.add_key(1)
        end

      else
        if tile == 'D'
          if @player.keys <= 0
            puts "You need a key to get through that door!"
          else
            puts "You unlocked the door with a key!"
            @player.move(dirx, diry)
            @player.add_key(-1)
          end
        else
          puts "Cannot move there!"
        end
      end
    end
    
    if text[help]
      print_help
    elsif text[inventory]
      @player.print_inventory
    elsif text[quit]
      return false
    end
      
    return true
  end

  def game_loop!
    #instruct
    remain = true
    puts "At any time, type 'h' or 'help' to see input controls."
    while remain
      print_view
      input = gets.chomp
      remain = parse!(input)
    end
  end

end

