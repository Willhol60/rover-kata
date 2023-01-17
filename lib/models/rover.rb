# frozen_string_literal: true

require_relative "../initializers/rover_initializer.rb"
require_relative "./direction.rb"
require_relative "../event_source.rb"

class Rover
  attr_accessor :position, :direction_name, :direction_value, :clear, :events
  attr_reader :obstacles, :commands, :size

  def initialize(args)
    @position = RoverInitializer.position_generator(args[:position])
    @direction_name = args[:direction]
    @direction_value = Direction.assign_direction_value(args[:direction])
    @obstacles = RoverInitializer.obstacle_generator(args[:obstacles])
    @size = args[:size].to_i || 9
    @commands = args[:commands]
    @clear = true
    @events = EventSource.new
  end

  def current_position
    string = "#{@position.x} X #{@position.y} #{@direction_name}"

    @clear ? string : string + " NOK"
  end
end
