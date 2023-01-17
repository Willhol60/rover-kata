# frozen_string_literal: true

require_relative "../models/position.rb"
require_relative "../models/obstacle.rb"

class RoverInitializer
  def self.position_generator(user_specified_position)
    return Models::Position.new(0,0) unless user_specified_position

    x, y = user_specified_position.split('')
    Models::Position.new(x.to_i, y.to_i)
  end

  def self.obstacle_generator(user_specified_obstacles)
    return nil unless user_specified_obstacles

    obstacles = []

    user_specified_obstacles.split('').each_slice(2) do |obstacle_coordinates|
      x, y = obstacle_coordinates
      obstacles << Models::Obstacle.new(x.to_i, y.to_i)
    end

    obstacles
  end
end
