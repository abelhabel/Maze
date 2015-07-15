# Print module prints to the terminal
require './level.rb'
module Print
  def self.help
    puts '--Input the characters below and hit ENTER to execute the commands.--'
    puts 'Use the keyboard to move. N=North, S=South, W=West, E=East'
    puts 'I or Inventory to open inventory.'
    puts 'Q or Quit to exit the game.'
    puts ''
    puts '--The characters below have the following meaning--'
    puts '# means that you cannot move there.'
    puts 'X is the edge of the maze.'
    puts 'D is a door.'
    puts 'K is a key.'
    puts 'E is the maze Exit and end goal.'
    puts '- is a walkable tile.'
  end

  def self.view(ulrd)
    # ulrd = up left right down
    puts '---------'
    puts "|   #{ulrd[0]}   |"
    puts "| #{ulrd[1]} ♀ #{ulrd[2]} |"
    puts "|   #{ulrd[3]}   |"
    puts '---------'
  end
end
