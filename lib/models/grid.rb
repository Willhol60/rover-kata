# frozen_string_literal: true


class Grid
  attr_reader :obstacles, :size
  DEFAULT_SIZE = 9

  def initialize(obstacles:, size: DEFAULT_SIZE)
    @obstacles = RoverInitializer.generate_obstacles(obstacles)
    @size = size
  end
end
