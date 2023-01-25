# frozen_string_literal: true

require_relative "../lib/parser.rb"
require_relative "../lib/models/rover.rb"
require_relative "./navigator.rb"
require_relative "../event_storage.rb"
require_relative "../lib/models/grid.rb"

user_options = RoverParser.new.parse(ARGV)

puts "Rover starting at position x:#{user_options[:position][0]} y:#{user_options[:position][1]}, facing #{user_options[:direction]}"
puts "Obstacles at x:#{user_options[:obstacles][0]} y:#{user_options[:obstacles][1]}"
puts "Size of sphere: #{user_options[:size] || Grid::DEFAULT_SIZE}"
puts "Following commands: #{user_options[:commands]}",""

rover = Rover.new(position: user_options[:position], direction: user_options[:direction], commands: user_options[:commands])
grid = Grid.new(obstacles: user_options[:obstacles], size: user_options[:size])
events = EventStorage.new
navigator = Navigator.new(rover, grid, events)
rover.commands.each_char do |command|
  navigator.execute_command(command)
  break unless rover.clear?
end

puts '*Obstacle encountered - no more commands will be executed*' if !rover.clear?
puts "Results of navigation:\nPosition - x:#{rover.position.x} y:#{rover.position.y}\nDirection - #{rover.direction_name}"
