# Players handles position
# 0 errors in rubocop
class Player
  def initialize(name, pos)
    @name = name
    @position = pos
    @keys = 0
  end

  attr_accessor :name
  attr_accessor :position
  attr_reader :keys

  def add_key!(num)
    @keys += num
  end

  def print_inventory
    puts "You have #{@keys} keys."
  end

  def move!(x, y)
    @position[:x] += x
    @position[:y] += y
  end
end
