require './player.rb'
require './helper.rb'
require './level.rb'
class Game
  def initialize(player_name)
    @player = Player.new(player_name, {})
    @current_layer = 0
    @level = Level.new(0)
  end
  attr_reader :level
  attr_reader :start_pos
  def update_player_position!
    @player.position = Helper.get_current_pos(@level.get_map)
  end
  private
  def print_help
    puts "--Input the characters below and hit ENTER to execute the commands.--"
    puts "Use the keyboard to move. N=North, S=South, W=West, E=East"
    puts "I or Inventory to open inventory."
    puts "Q or Quit to exit the game."
    puts ''
    puts "--The characters below have the following meaning--"
    puts "# means that you cannot move there."
    puts "X is the edge of the maze."
    puts "D is a door."
    puts "K is a key."
    puts "E is the maze Exit and end goal."
    puts "- is a walkable tile."
  end

  def print_view
    left = Helper.get_tile(@level.get_map, @player.position[:x] -1, @player.position[:y])
    right = Helper.get_tile(@level.get_map, @player.position[:x] +1, @player.position[:y])
    up = Helper.get_tile(@level.get_map, @player.position[:x], @player.position[:y] -1)
    down = Helper.get_tile(@level.get_map, @player.position[:x], @player.position[:y] + 1)
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
      Helper.set_tile(@level.get_map, @player.position[:x], @player.position[:y], '-')
      tile = Helper.get_tile(@level.get_map, @player.position[:x] + dirx, @player.position[:y] + diry)
      if tile.match(/[-EK]/)
        @player.move!(dirx, diry)
        if tile == 'E'
          puts "You found the exit!"
          if @level.next_level!
            update_player_position!
            puts "However, all you found was a new maze! The horror!"
          else
            puts "Congratulations to completing the game."
            puts "Credits"
            puts "Programming: Andreas Olsson"
            puts "Design: Andreas Olsson"
            puts "Graphics: Andreas Olsson"
            puts "A/V-FX: Jorv Xerxor"
            return false;
          end
        end
        if tile == 'K'
          puts "You found a key!"
          @player.add_key!(1)
        end
      else
        if tile == 'D'
          if @player.keys <= 0
            puts "You need a key to get through that door!"
          else
            puts "You unlocked the door with a key!"
            @player.move!(dirx, diry)
            @player.add_key!(-1)
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

  public
  def game_loop!
    #instruct
    remain = true
    update_player_position!
    puts "Welcome to The Maze, #{@player.name}."
    puts "The square below shows you the immediate tiles to the North, South, West and East."
    puts "At any time, type 'h' or 'help' to see what the characters mean and to see input controls."
    while remain
      print_view
      input = gets.chomp
      remain = parse!(input)
    end
  end

end

