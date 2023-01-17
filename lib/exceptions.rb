# frozen_string_literal: true

class InvalidDirection < StandardError
  def initialize(msg="Invalid Direction, please put one of [N, E, S, W]")
    super
  end
end

class InvalidCommand < StandardError
  def initialize(msg="Invalid Command, please put one of [F, B, L, R, U]")
    super
  end
end
