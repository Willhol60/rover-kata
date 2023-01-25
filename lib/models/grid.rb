# frozen_string_literal: true

DEFAULT_SIZE = 9

class Grid
  attr_reader :obstacles, :size

  def initialize(obstacles:, size: DEFAULT_SIZE)
    @obstacles = RoverInitializer.generate_obstacles(obstacles)
    @size = size
  end
end
