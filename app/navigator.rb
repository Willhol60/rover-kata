# frozen_string_literal: true

require 'pry'

class Navigator
  def initialize(rover, grid, events)
    @rover = rover
    @grid = grid
    @events = events
  end

  def execute_command(command)
    # get coordinates if moving (not turning), or turn and finish
    get_coordinates(command) # to be renamed
    # go to decision making entity
      # check for obstacles
      # check for boundaries
    # return decision of whether to move or not
    # make move (or not)
  end
  
  private
  
  def get_coordinates(command)
    downcased = command.downcase
  
    case downcased
    when 'f', 'b'
      move(@rover.direction_value, downcased)
      @events.store_event(command)
    when 'l', 'r'
      turn(downcased)
      @events.store_event(command)
    when 'u'
      undo_last_move
    else
      raise RoverExceptions::InvalidCommand.new("#{command} is an invalid command, please put one of [F, B, L, R, U]")
    end
  end

  def move(direction_value, movement)
    key = {'f'=>1, 'b'=>-1}

    case direction_value
    when 0
      @rover.position.y += key[movement]
    when 1
      @rover.position.x += key[movement]
    when 2
      @rover.position.y -= key[movement]
    when 3
      @rover.position.x -= key[movement]
    end

    check_for_boundaries
    check_for_obstacles
  end
  
  def turn(direction)
    if direction == 'l'
      @rover.direction_value > 0 ? @rover.direction_value -= 1 : @rover.direction_value = 3
    else
      @rover.direction_value < 3 ? @rover.direction_value += 1 : @rover.direction_value = 0
    end

    @rover.direction_name = Direction.source_direction_name(@rover.direction_value)
  end

  def check_for_boundaries
    if @rover.position.x > @grid.size
      @rover.position.x = 0
    elsif @rover.position.x < 0
      @rover.position.x = @grid.size
    elsif @rover.position.y > @grid.size
      @rover.position.y = 0
    elsif @rover.position.y < 0
      @rover.position.y = @grid.size
    end
  end

  require 'set'

  def check_for_obstacles
    return unless @grid.obstacles

    # obstacles_set = Set.new

    # @grid.obstacles.each do |obstacle|
    #   obstacles_set << obstacle.values
    # end

    # if obstacles_set.include? @rover.position # proposed position to be passed as param instead of @rover.position
    #     @rover.set_clear_false
    #     undo_last_move
    # end
    @grid.obstacles.each do |obstacle|
      if obstacle.x == @rover.position.x && obstacle.y == @rover.position.y
        @rover.set_clear_false
        undo_last_move
      end
    end
  end

  def undo_last_move
    last_command = @events.event_trace.pop.downcase
    # make it possible to go back any number of commands with a slider
    # don't use pop, use size of array minus x

    case last_command
    when 'f'
      move(@rover.direction_value, 'b')
    when 'b'
      move(@rover.direction_value, 'f')
    when 'l'
      turn('r')
    when 'r'
      turn('l')
    when 'u'
      undo_last_move
    when nil
      return
    end
  end
end
