# frozen_string_literal: true

require_relative "../initializers/rover_initializer.rb"

class Rover
  attr_accessor :position, :direction_name, :direction_value, :events
  attr_reader :commands

  def initialize(position:, direction:, commands:)
    @position = RoverInitializer.generate_position(position)
    @direction_name = direction
    @direction_value = RoverInitializer.assign_direction_value(direction)
    @commands = commands

    @clear = true
  end

  def current_position
    string = "#{@position.x} X #{@position.y} #{@direction_name}"

    clear? ? string : string + " NOK"
  end

  def clear?
    @clear
  end

  def set_clear_false
    @clear = false
  end
end
