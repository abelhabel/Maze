require './layers.rb'
module Helper
  def self.get_current_pos(layer)
    xi = 0
    yi = 0
    layer.each_index {|y|
      layer[y].each_index{|x|
        if layer[y][x] == 'C'
          yi = y
          xi = x
        end
      }
    }
    return {y: yi, x:xi}
  end

  def self.get_tile(layer, posx, posy)
    maxy = $layers[:tiles].count
    maxx = $layers[:tiles][$layers[:tiles].count-1].count
    return 'X' if posy >= maxy
    return 'X' if posx >= maxx
    $layers[:tiles][posy][posx]
  end

  def self.set_tile(layer, posx, posy, set_to)
    $layers[:tiles][posy][posx] = set_to
  end
end