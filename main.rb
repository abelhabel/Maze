# 0 errors in rubocop
require './game.rb'
require 'active_record'
require 'rubygems'
require 'highline/import'
require_relative 'player'
require_relative 'score'

def play(player)
  game = Game.new(player)
  game.game_loop!
  Score.create(player_id: player.id, score: game.calculate_score)
end

def get_user
  puts 'Please enter your username'
  u_name = gets.chomp
  @find_player = Player.find_by_user_name(u_name)
  if @find_player
    @find_player
  else
    u_name
  end
end

def login
  begin 
    @player_user = get_user  
    if @player_user.is_a? Player
      temp_pass = ask("Please enter your password: ") { |q| q.echo = false }
      @player = Player.authenticate(@player_user, temp_pass)
      if @player
        @player.custom_initialize
        play(@player)
      else
        puts 'Wrong password'
      end
    end
  end while !@player.is_a? Player
end

def create
  begin
    @create_player = get_user
    if !@create_player.is_a? Player
      @new_password = ask('Please enter a password to create your account:') { |q| q.echo = false }
      @new_password_confirmation = ask('Please confirm your password:') { |q| q.echo = false }
      @new_player = Player.create(user_name: @create_player, new_password: @new_password, new_password_confirmation: @new_password_confirmation)
      if @new_player.id
        @new_player.custom_initialize
        play(@new_player)
      else
        puts "Passwords did not match"
      end
    else
      puts "Username already exists."
    end
  end while !@new_player.id
end

def connect
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
end

def run
  connect
  puts "L: login to account \nC: create new account"
  input = gets.chomp
  case input.downcase
    when 'l' then login
    when 'c' then create   
  end
  show_high_scores
end

def show_high_scores
  x = Score.joins('JOIN players ON players.id = scores.player_id ORDER BY scores.score DESC LIMIT(10)')
  puts "Highscore Table:"
  puts "-"*35
  puts "Name" +" "*(26)+"Score"
  puts "-"*35
  x.each {|i| puts "#{i.player.user_name}"+" "*(30-i.player.user_name.length)+"#{i.score}" }
end

run
