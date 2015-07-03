#include
require './game.rb'



#test code
def main_loop(game)
  game.game_loop!
end

def run
  puts "Input your name: "
  name = gets.chomp
  game = Game.new(name)
  main_loop(game)
end

run()