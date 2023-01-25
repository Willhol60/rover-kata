# frozen_string_literal: true

require_relative "../lib/models/rover.rb"

RSpec.describe RoverInitializer do
  let(:position) { '37' }
  let(:direction) { 'N' }
  let(:obstacles) { '88' }
  let(:commands) { 'FB' }
  let(:args) { {position: position, direction: direction, obstacles: obstacles, commands: commands} }
  
  it "should set rover position" do
    expect(described_class.generate_position(position).x).to eq position[0].to_i
  end

  it "should set obstacles" do
    expect(described_class.generate_obstacles(obstacles).first.x).to eq obstacles[0].to_i
  end
end
