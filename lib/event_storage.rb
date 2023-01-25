# frozen_string_literal: true

class EventStorage
  attr_reader :event_trace

  def initialize
    @event_trace = Array.new
  end

  def store_event(event)
    @event_trace << event
  end

end
