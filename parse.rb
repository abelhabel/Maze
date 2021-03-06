
class Parser

  def initialize

  end

  # when "\e[A"
  #   puts "UP ARROW"
  # when "\e[B"
  #   puts "DOWN ARROW"
  # when "\e[C"
  #   puts "RIGHT ARROW"
  # when "\e[D"
  #   puts "LEFT ARROW"

  def self.parse(text, player, level)
    north = 'up'
    south = 'down'
    west = 'left'
    east = 'right'
    help = 'help'
    quit = 'quit'
    inventory = 'inventory'

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
      tile = level.get_tile(player.position[:x] + dirx, player.position[:y] + diry)
      if tile.match(/[-EKGTC]/)
        player.move!(dirx, diry)
        if tile == 'E'
          puts 'You found the exit!'
          if level.next_level!
            # update_player_position!
            player.position = level.current_pos
            puts 'However, all you found was a new maze! The horror!'
          else
            puts 'Congratulations to completing the game.'
            puts 'Credits'
            puts 'Programming: Andreas Olsson and Laith Azer'
            puts 'Design: Andreas Olsson'
            puts 'Graphics: Andreas Olsson'
            return false
          end
        end
        if tile == 'K'
          puts 'You found a key!'
          player.add_key(1)
        end
        if tile == 'G'
          puts 'You found a Gem. Wonder what that could be used for.'
          player.add_gem(1)
        end
        if tile == 'T'
          puts 'You found a treasure! Save it!'
          player.add_treasure(1)
        end
        level.set_tile!(player.position[:x], player.position[:y], '-')
      else
        if tile == 'D'
          if player.keys <= 0
            puts 'You need a key to get through that door!'
          else
            puts 'You unlocked the door with a key!'
            player.move!(dirx, diry)
            player.add_key(-1)
            level.set_tile!(player.position[:x], player.position[:y], '-')
          end
        elsif tile == 'P'
          if player.gems <= 0
            puts 'You need a gem to activate the Portal!'
          else
            puts "You activated the portal with one of your gems!"
            player.move!(dirx, diry)
            next_pos = level.next_portal(player.position)
            player.move_to(next_pos)
            player.add_gem(-1)
          end
        else
          puts 'Cannot move there!'
        end
      end
    end
    
    if text[help]
      Print.help
    elsif text[inventory]
      player.print_inventory
    elsif text[quit]
      return false
    end
      
    true
  end
end