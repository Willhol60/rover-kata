# frozen_string_literal: true

require 'pry'

require_relative './decision_maker.rb'

class Navigator
  def initialize(rover, grid, events)
    @rover = rover
    @grid = grid
    @events = events
    @decision_maker = DecisionMaker.new(grid)
  end

  def execute_command(command)
    downcased = command.downcase

    case downcased
    when 'f', 'b'
      proposed_position = @decision_maker.check_for_boundaries(provisional_move(downcased))
      make_move_or_process_obstacle(proposed_position, downcased)
    when 'l', 'r'
      turn(downcased)
    when 'u'
      undo_last_move
    else
      raise RoverExceptions::InvalidCommand.new("#{command} is an invalid command, please put one of [F, B, L, R, U]")
    end
  end
  
  private

  def provisional_move(movement)
    key = {'f'=>1, 'b'=>-1}

    case @rover.direction_value
    when 0
      Models::Position.new(@rover.position.x, @rover.position.y + key[movement])
    when 1
      Models::Position.new(@rover.position.x + key[movement], @rover.position.y)
    when 2
      Models::Position.new(@rover.position.x, @rover.position.y - key[movement])
    when 3
      Models::Position.new(@rover.position.x - key[movement], @rover.position.y)
    end
  end

  def make_move_or_process_obstacle(position, command)
    if @decision_maker.obstacle_present?(position)
      @rover.set_clear_false
    else
      @rover.position = position
      @events.store_event(command)
    end
  end
  
  def turn(direction)
    key = {'l'=>-1, 'r'=>1}

    @rover.direction_value = (@rover.direction_value += key[direction]) % 4
    @rover.direction_name = Direction.source_direction_name(@rover.direction_value)
    @events.store_event(direction)
  end

  def simple_move(direction_value, movement)
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
  end

  def undo_last_move
    last_command = @events.event_trace.pop.downcase

    case last_command
    when 'f'
      simple_move(@rover.direction_value, 'b')
    when 'b'
      simple_move(@rover.direction_value, 'f')
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
