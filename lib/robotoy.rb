require "robotoy/robot"
require "robotoy/input"

module Robotoy
  def self.start_game
    input = Robotoy::Input.new
    input.run
  end
end
