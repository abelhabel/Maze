# Players handles position
# 0 errors in rubocop
require 'bcrypt'
require 'active_record'

class Player < ActiveRecord::Base
  
  include BCrypt
  has_many :scores
  validates_confirmation_of :new_password #:if=>:password_changed?
  before_save :hash_new_password #:if=>:password_changed?

  attr_accessor :name, :position, :new_password, :new_password_confirmation
  attr_reader :keys, :gems, :treasures, :steps

  def custom_initialize
    @position = {}
    @keys = 0
    @gems = 0
    @treasures = 0
    @steps = 0
  end

  def add_key(num)
    @keys += num
  end

  def add_gem(num)
    @gems += num
  end

  def add_step(num)
    @steps += num
  end

  def add_treasure(num)
    @treasures += num
  end

  def print_inventory
    puts "You have #{@keys} key(s)." if @keys > 0
    puts "You have #{@gems} gem(s)." if @gems > 0
    puts "You have #{@treasures} treasure(s)." if @treasures > 0
  end

  def move!(x, y)
    self.add_step(1)
    @position[:x] += x
    @position[:y] += y
  end
  
  def move_to(pos)
    @position = pos
  end

  # def password_changed?
  #   !@new_password.blank?
  # end

  def self.authenticate(user, password)
    if user
      if BCrypt::Password.new(user.hashed_password).is_password? password
        return user
      end
    end
    return nil
  end

  private
  
  def hash_new_password
    self.hashed_password = BCrypt::Password.create(@new_password)
  end

end
