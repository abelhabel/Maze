# Level stores the current level loaded.
# 'missing top level class commer' in rubocop. disregard
require './loader.rb'
class Level
  attr_reader :map
  def initialize(level)
    @current_level = level
    @map = Loader.load_level(level)
  end

  def get_tile(posx, posy)
    maxy = @map.count
    maxx = @map[@map.count - 1].count
    return 'X' if (posy >= maxy || posy < 0)
    return 'X' if (posx >= maxx || posx < 0)
    @map[posy][posx]
  end

  def get_adjacent_tiles(posx, posy)
    arr = [[0, -1], [-1, 0], [1, 0], [0, 1]]
    arr.map { |p| get_tile(posx + p[0], posy + p[1]) }
  end

  def set_tile!(posx, posy, set_to)
    @map[posy][posx] = set_to
  end

  def current_pos
    pos = { y: 0, x: 0 }
    @map.each_index do |y|
      @map[y].each_index do |x|
        if @map[y][x] == 'C'
          pos[:x] = x
          pos[:y] = y
        end
      end
    end
    pos
  end

  def next_portal(exclude_pos)
    p = {}
    @map.each_index do |y| 
      @map[y].each_index do |x|
        if ( @map[y][x] == 'P' && !(y == exclude_pos[:y] && x == exclude_pos[:x]) )
          p[:y] = y
          p[:x] = x 
        end
      end
    end
    puts p
    p
  end

  def next_level!
    @current_level += 1
    @map = Loader.load_level(@current_level)
  end
end
