require './saveload.rb'
class Level
  def initialize(level)
    @current_level = level
    @map = load_level(level)
  end

  def next_level!
    @current_level += 1
    @map = load_level(@current_level)
  end

  def get_map
    @map
  end
end