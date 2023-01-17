# frozen_string_literal: true

class Navigator
  def initialize(rover)
    @rover = rover
  end

  def execute_commands
    @rover.commands.split('').each do |command|
      execute_command(command)
      break unless @rover.clear
    end
  end

  private
  
  def execute_command(command)
    downcased = command.downcase

    if %w(f b).include? downcased
      move(@rover.direction_value, downcased)
    elsif %w(l r).include? downcased
      turn(downcased)
    elsif downcased == 'u'
      undo_last_move
    else
      raise InvalidCommand.new
    end

    @rover.events.store_event(command) unless downcased == 'u'
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
    if @rover.position.x > @rover.size
      @rover.position.x = 0
    elsif @rover.position.x < 0
      @rover.position.x = @rover.size
    elsif @rover.position.y > @rover.size
      @rover.position.y = 0
    elsif @rover.position.y < 0
      @rover.position.y = @rover.size
    end
  end

  def check_for_obstacles
    return unless @rover.obstacles

    @rover.obstacles.each do |obstacle|
      if obstacle.x == @rover.position.x && obstacle.y == @rover.position.y
        @rover.clear = false
        undo_last_move
      end
    end
  end

  def undo_last_move
    last_command = @rover.events.event_trace.pop.downcase

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
