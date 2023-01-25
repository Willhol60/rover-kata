# frozen_string_literal: true

require 'optparse'

class RoverParser
  def parse(args)
    options = {}
    opts = OptionParser.new do |opts|
      opts.on('-p', '--position POSITION', 'starting position for the rover e.g 37') do |position|
        options[:position] = position
      end
      opts.on('-d', '--direction DIRECTION', 'direction the rover is facing e.g 12W') do |direction|
        options[:direction] = direction
      end
      opts.on('-o', '--obstacles OBSTACLES', 'position of obstacles e.g 12 or 1232') do |obstacles|
        options[:obstacles] = obstacles
      end
      opts.on('-s', '--size SIZE', 'size of sphere e.g 8') do |size|
        options[:size] = size.to_i
      end
      opts.on('-c', '--commands COMMANDS', 'commands for rover to move e.g LFLFLFLFU') do |commands|
        options[:commands] = commands
      end

    end
    opts.parse(args)
    options
  end
end
