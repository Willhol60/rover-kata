# frozen_string_literal: true

require 'set'

class DecisionMaker
  def initialize(grid)
    @grid_size = grid.size
    
    @obstacles_set = Set.new
  
    grid.obstacles.each do |obstacle|
      @obstacles_set << obstacle.values
    end
  end

  def check_for_boundaries(proposed_position)
    if proposed_position.x > @grid_size
      Models::Position.new(0, proposed_position.y)
    elsif proposed_position.x < 0
      Models::Position.new(@grid_size, proposed_position.y)
    elsif proposed_position.y > @grid_size
      Models::Position.new(proposed_position.x, 0)
    elsif proposed_position.y < 0
      Models::Position.new(proposed_position.x, @grid_size)
    else
      proposed_position
    end
  end

  def obstacle_present?(proposed_position)
    @obstacles_set.include? proposed_position.values
  end
end
