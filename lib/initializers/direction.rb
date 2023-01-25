# frozen_string_literal: true

require_relative "../exceptions.rb"

class Direction
  DIRECTIONS = %w(N E S W).freeze

  def self.assign_direction_value(direction)
    DIRECTIONS.index(direction) ||raise(RoverExceptions::InvalidDirection.new("#{direction} is an invalid direction, please put one of [N, E, S, W]"))
  end
  
  def self.source_direction_name(value)
    DIRECTIONS[value]
  end
end
