# Players handles position
# 0 errors in rubocop
class Player

  attr_accessor :name
  attr_accessor :position
  attr_reader :keys, :gems, :treasures

  def initialize(name, pos)
    @name = name
    @position = pos
    @keys = 0
    @gems = 0
    @treasures = 0
  end

  def add_key(num)
    @keys += num
  end

  def add_gem(num)
    @gems += num
  end

  def add_treasure(num)
    @treasures += num
  end

  def print_inventory
    puts "You have #{@keys} keys." if @keys > 0 
    puts "You have #{@gems} gems." if @gems > 0
  end

  def move!(x, y)
    @position[:x] += x
    @position[:y] += y
  end
  
  def move_to(pos)
    @position = pos
  end
end
