# frozen_string_literal: true

require_relative "../lib/parser.rb"
require_relative "../lib/models/rover.rb"
require_relative "./navigator.rb"

user_options = RoverParser.parse(ARGV)

puts "Rover starting at position x:#{user_options[:position][0]} y:#{user_options[:position][1]}, facing #{user_options[:direction]}"
puts "Obstacles at x:#{user_options[:obstacles][0]} y:#{user_options[:obstacles][1]}"
puts "Size of sphere: #{user_options[:size] || 9}"
puts "Following commands: #{user_options[:commands]}",""

rover = Rover.new(user_options)
Navigator.new(rover).execute_commands

puts '*Obstacle encountered - no more commands will be executed*' if !rover.clear
puts "Results of navigation:\nPosition - x:#{rover.position.x} y:#{rover.position.y}\nDirection - #{rover.direction_name}"
