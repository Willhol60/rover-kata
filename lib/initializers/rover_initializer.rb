# frozen_string_literal: true

require_relative "../models/position.rb"
require_relative "../models/obstacle.rb"
require_relative "./direction.rb"

class RoverInitializer
  def self.generate_position(user_specified_position)
    return Models::Position.new(0,0) unless user_specified_position

    x, y = user_specified_position.chars
    Models::Position.new(x.to_i, y.to_i)
  end

  def self.assign_direction_value(direction)
    Direction.assign_direction_value(direction)
  end

  def self.generate_obstacles(user_specified_obstacles)
    return unless user_specified_obstacles

    user_specified_obstacles.chars.each_slice(2).map do |obstacle_coordinates|
      x, y = obstacle_coordinates
      Models::Obstacle.new(x.to_i, y.to_i)
    end
  end
end
