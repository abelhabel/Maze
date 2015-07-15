# 0 errors in rubocop
require './game.rb'

def main_loop(game)
  game.game_loop!
end

def run
  puts 'Input your name: '
  name = gets.chomp

  game = Game.new(name)
  start_time = Time.now
  if main_loop(game) == 'finished'
    end_time = Time.now
    save_to_database
  end
end

run