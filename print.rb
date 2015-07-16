# Print module prints to the terminal
require './level.rb'
module Print
  def self.help
    puts 'Use the arrow keys on your keyboard to move up, down, left and righ.'
    puts '--Input the characters below for the following commands.--'
    puts 'I to open inventory.'
    puts 'Q to exit the game.'
    puts ''
    puts '--The characters below have the following meaning--'
    puts '# means a wall and you cannot move there.'
    puts '- is a walkable tile.'
    puts 'X is the edge of the maze.'
    puts 'D is a door.'
    puts 'K is a key.'
    puts 'E is the maze Exit and end goal.'
    puts 'G is a Gem.'
    puts 'P is a Portal.'
    puts 'T is a treasure. It gives you extra points in your final score.'
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
