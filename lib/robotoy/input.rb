require "robotoy/robot"

module Robotoy
  class Input
    PLACE  = "PLACE".freeze
    MOVE   = "MOVE".freeze
    LEFT   = "LEFT".freeze
    RIGHT  = "RIGHT".freeze
    REPORT = "REPORT".freeze
    HELP   = "help".freeze
    EXIT   = "exit".freeze

    # @param [Object] robot
    def initialize(robot = Robot.new)
      @robot      = robot
      @robot_init = false
    end

    def run
      Kernel.loop do
        command, args = parse_commands(gets.strip)

        case command
        when PLACE
          @robot.place(*args)
          @robot_init = true
        when MOVE
          @robot.move if @robot_init
        when LEFT
          @robot.rotate(LEFT) if @robot_init
        when RIGHT
          @robot.rotate(RIGHT) if @robot_init
        when REPORT
          @robot.report if @robot_init
        when HELP
          help
        when EXIT
          break
        else
          puts "Invalid command!"
        end
      end
    end

    # @param [String] input
    # @return [Array][String]
    def parse_commands(input)
      command, args = input.split(" ")
      args = args.split(",").map { |n| Integer(n) rescue ArgumentError n } if args

      [command, args]
    end

    def help
      message = <<~HELP
        PLACE 0,0,NORTH -> direction [NORTH, EAST, SOUTH, WEST], table limit 5x5
        MOVE            -> move one step in current direction
        REPORT          -> Output: 0,0,NORTH
        LEFT or RIGHT   -> changing directions
      HELP

      puts message
    end
  end
end
