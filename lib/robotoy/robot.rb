module Robotoy
  class Robot
    X_LENGTH = 5
    Y_LENGTH = 5

    NORTH = "NORTH".freeze
    SOUTH = "SOUTH".freeze
    EAST  = "EAST".freeze
    WEST  = "WEST".freeze

    LEFT  = "LEFT".freeze
    RIGHT = "RIGHT".freeze

    MOVE_STEP = 1

    # @param [Integer] x_length
    # @param [Integer] y_length
    def initialize(x_length = X_LENGTH, y_length = Y_LENGTH, logger = Logger)
      raise ArgumentError, "Table length can't be smaller that 1" if x_length < 1 || y_length < 1

      @x_coordinate_length = x_length
      @y_coordinate_length = y_length
      @x_coordinate        = 0
      @y_coordinate        = 0
      @directions          = [NORTH, EAST, SOUTH, WEST]
      @direction           = nil
      @logger              = logger
    end

    def move
      case @direction
      when NORTH
        x_coordinate  = @x_coordinate + MOVE_STEP
        @x_coordinate = x_coordinate if x_coordinate <= @x_coordinate_length
      when EAST
        y_coordinate  = @y_coordinate + MOVE_STEP
        @y_coordinate = y_coordinate if y_coordinate <= @y_coordinate_length
      when SOUTH
        x_coordinate  = @x_coordinate - MOVE_STEP
        @x_coordinate = x_coordinate unless x_coordinate.negative?
      when WEST
        y_coordinate  = @y_coordinate - MOVE_STEP
        @y_coordinate = y_coordinate unless y_coordinate.negative?
      else
        raise ArgumentError, "Unsupported direction!"
      end
    end

    # @param [Integer] x_coordinate
    # @param [Integer] y_coordinate
    # @param [String] direction
    def place(x_coordinate, y_coordinate, direction)
      raise ArgumentError, "Invalid coordinates!" if x_coordinate.negative? || y_coordinate.negative?
      raise ArgumentError, "Invalid direction!" unless [NORTH, EAST, SOUTH, WEST].include? direction

      @x_coordinate = x_coordinate
      @y_coordinate = y_coordinate
      @direction    = direction
      loop { @directions.first == direction ? break : @directions.rotate! }

      raise ArgumentError, "Invalid direction!" if @direction.nil?
    end

    # @return [String]
    def report
      @logger.info("Output: #{@x_coordinate},#{@y_coordinate},#{@direction}")
    end

    # @param [String] direction
    def rotate(direction)
      @direction = case direction
                   when LEFT
                     @directions.rotate!(-1).first
                   when RIGHT
                     @directions.rotate!.first
                   else
                     raise ArgumentError, "Invalid direction!"
                   end
      true
    end

    Direction = Struct.new(:left, :right, :current)
  end
end
