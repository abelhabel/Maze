# 0 errors in rubocop
require './game.rb'
require 'active_record'
require_relative 'player'
require_relative 'score'

def play(player)
  game = Game.new(player)
  game.game_loop!
  Score.create(player_id: player.id, score: player.treasures)
end

def run
  ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'd94rlf5a0tajfv',
  username: 'yrinmpfezklsvp',
  password: 'lC8z5STnpJDrBLGiheiDWUqZZ4',
  host: 'ec2-54-83-36-176.compute-1.amazonaws.com',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error')
  puts 'Please enter your username'
  u_name = gets.chomp
  @player_user = Player.find_by_user_name(u_name)
  puts 'Please enter your password'
  temp_pass = gets.chomp
  @player = Player.authenticate(@player_user, temp_pass)
  if @player
    @player.custom_initialize
    play(@player)  
  else
    puts 'Account doesnt exist. 
    Please enter a password to create your account:'
    new_password = gets.chomp
    puts 'Please confirm your password:'
    @new_player = Player.create(user_name: u_name, new_password: new_password, new_password_confirmation: gets.chomp)
    @new_player.custom_initialize
    play(@new_player)
  end  
end

run