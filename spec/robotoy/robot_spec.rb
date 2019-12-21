require "spec_helper"

describe Robotoy::Robot do
  subject { described_class.new }

  let(:x) { 1 }
  let(:y) { 1 }
  let(:direction) { Robotoy::Robot::NORTH }

  describe "place" do
    context "place with invalid coordinate" do
      it "raises runtime error" do
        expect { subject.place(1, -1, direction) }.to raise_error(ArgumentError, "Invalid coordinates!")
      end

      it "raises runtime error" do
        expect { subject.place(-1, 1, direction) }.to raise_error(ArgumentError, "Invalid coordinates!")
      end
    end

    context "place with invalid direction" do
      it "raises runtime error" do
        expect { subject.place(1, 1, "xyz") }.to raise_error(ArgumentError, "Invalid direction!")
      end
    end
  end

  describe "rotate" do
    before do
      subject.place(x, y, direction)
    end

    it "rotates to right" do
      subject.rotate(Robotoy::Robot::RIGHT)
      expect { subject.report }.to output("Output: #{x},#{y},#{Robotoy::Robot::EAST}\n").to_stdout
    end

    it "rotates to left" do
      subject.rotate(Robotoy::Robot::LEFT)
      expect { subject.report }.to output("Output: #{x},#{y},#{Robotoy::Robot::WEST}\n").to_stdout
    end

    it "rotates to left" do
      expect { subject.rotate("xyz") }.to raise_error(ArgumentError, "Invalid direction!")
    end
  end

  describe "move" do
    it "north 1 step" do
      subject.place(0, 0, Robotoy::Robot::NORTH)
      subject.move
      expect { subject.report }.to output("Output: 1,0,NORTH\n").to_stdout
    end

    it "out of table" do
      subject.place(0, 0, Robotoy::Robot::NORTH)
      subject.rotate(Robotoy::Robot::LEFT)
      subject.move
      expect { subject.report }.to output("Output: 0,0,WEST\n").to_stdout
    end

    it "2 steps to east than 1 step north" do
      subject.place(2, 1, Robotoy::Robot::EAST)
      subject.move
      subject.move
      subject.rotate(Robotoy::Robot::LEFT)
      subject.move
      expect { subject.report }.to output("Output: 3,3,NORTH\n").to_stdout
    end
  end

  describe "report" do
    it "prints current position and direction" do
      subject.place(x, y, direction)
      expect { subject.report }.to output("Output: #{x},#{y},#{direction}\n").to_stdout
    end
  end
end
