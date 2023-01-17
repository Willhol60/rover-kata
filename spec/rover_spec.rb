# frozen_string_literal: true

require_relative "../lib/models/rover.rb"
require_relative "../app/navigator.rb"

RSpec.describe Rover do
  subject(:run_navigator) { Navigator.new(rover).execute_commands }

  let(:rover) { described_class.new(args) }

  let(:position_x) { 3 }
  let(:position_y) { 7 }
  let(:position) { position_x.to_s + position_y.to_s }

  let(:direction) { 'N' }

  let(:obstacle_x) { 8 }
  let(:obstacle_y) { 8 }
  let(:obstacles) { obstacle_x.to_s + obstacle_y.to_s }

  let(:size) { 9 }

  let(:commands) { '' }
  let(:args) { {position: position, direction: direction, obstacles: obstacles, size: size, commands: commands} }
  
  describe 'when receiving only one command' do
    describe "when command is F" do
      let(:commands) { 'F' }
      it "moves forwards" do
        expected = position_y + 1
        run_navigator
        expect(rover.position.y).to eq expected
      end
    end

    describe "when command is B" do
      let(:commands) { 'B' }
      it "moves backwards" do
        expected = position_y - 1
        run_navigator
        expect(rover.position.y).to eq expected
      end
    end

    describe "when command is L" do
      let(:commands) { 'L' }
      it "turns left" do
        run_navigator
        expect(rover.direction_name).to eq 'W'
      end
    end
  
    describe "when command is R" do
      let(:commands) { 'R' }
      it "turns right" do
        run_navigator
        expect(rover.direction_name).to eq 'E'
      end
    end

    describe 'when the command is lower case' do
      let(:commands) { 'r' }
      it "runs the command regardless" do
        run_navigator
        expect(rover.direction_name).to eq 'E'
      end
    end

    describe 'when command is unknown' do
      let(:commands) { 'X' }
      it "throws exception" do
        expect { run_navigator }.to raise_exception(InvalidCommand)
      end
    end
  end

  describe 'when receiving multiple commands' do
    let(:commands) { 'RFR' }
    it "runs them all" do
      expected_position = position_x + 1
      run_navigator
      expect(rover.position.x).to eq expected_position
      expect(rover.direction_name).to eq 'S'
    end
  end
  
  it "position returns X Y and Direction" do
    expect(rover.current_position).to eq "3 X 7 N"
  end
  
  describe "when an obstacle is in the rover's path" do
    let(:position_x) { '8' }
    let(:position_y) { '6' }
    let(:direction) { 'N' }
    let(:commands) { 'FFFFF' }
    it "stops" do
      expected_position_x = position_x.to_i
      expected_position_y = position_y.to_i + 1
      run_navigator    
      expect(rover.position.x).to eq expected_position_x
      expect(rover.position.y).to eq expected_position_y
    end
    
    it "position returns NOK" do
      run_navigator
      expect(rover.current_position).to end_with (" NOK")
    end
  end
  
  describe "when the rover navigates beyond the perimeter of the sphere" do
    let(:position_x) { 9 }
    let(:direction) { 'E' }
    let(:commands) { 'FF' }
    it "moves from one side of the sphere to the other" do
      run_navigator      
      expect(rover.position.x).to eq 1
    end
  end

  describe "when the rover is given the undo command" do
    let(:commands) { 'FFU' }
    it "reverses the most recent command" do
      expected_position_y = position_y.to_i + 2 - 1
      run_navigator
      expect(rover.position.y).to eq expected_position_y
    end
  end
end
