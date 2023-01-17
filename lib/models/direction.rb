# frozen_string_literal: true

require_relative "../exceptions.rb"

class Direction
  DIRECTIONS = { 'N'=>0, 'E'=>1, 'S'=>2, 'W'=> 3}

  def self.assign_direction_value(direction)
    DIRECTIONS[direction]
  rescue
    raise InvalidDirection.new
  end
  
  def self.source_direction_name(value)
    DIRECTIONS.key(value)
  end
end
