module Robotoy
  class Robot

    X_LENGTH = 5
    Y_LENGTH = 5

    NORTH = "NORTH".freeze
    SOUTH = "SOUTH".freeze
    EAST = "EAST".freeze
    WEST = "WEST".freeze

    LEFT = "LEFT".freeze
    RIGHT = "RIGHT".freeze

    MOVE_STEP = 1

    # @param [Integer] x_length
    # @param [Integer] y_length
    def initialize(x_length = X_LENGTH, y_length = Y_LENGTH)
      raise "Table length can't be smaller that 1" if x_length < 1 || y_length < 1

      @x_length = x_length
      @y_length = y_length
      @x = 0
      @y = 0

      north = Direction.new(WEST, EAST, NORTH)
      east = Direction.new(NORTH, SOUTH, EAST)
      south = Direction.new(EAST, WEST, SOUTH)
      west = Direction.new(SOUTH, NORTH, WEST)

      north.left = west; north.right = east
      east.left = north; east.right = south
      south.left = east; south.right = west
      west.left = south; west.right = north

      @directions = [north,east,south,west]

      @direction = nil
    end

    def move
      case @direction.current
      when NORTH
        r = @x + MOVE_STEP
        @x = r if r <= @x_length
      when EAST
        r = @y + MOVE_STEP
        @y = r if r <= @y_length
      when SOUTH
        r = @x - MOVE_STEP
        @x = r unless r.negative?
      when WEST
        r = @y - MOVE_STEP
        @y = r unless r.negative?
      else
        raise "Unsupported direction!"
      end
    end

    # @param [Integer] x
    # @param [Integer] y
    # @param [String] direction
    def place(x, y, direction)
      raise "Invalid coordinates!" if x.negative? || y.negative?

      @x = x
      @y = y
      @direction = @directions.select { |n| n.current == direction }.first

      raise "Invalid direction!" if @direction.nil?
    end

    # @return [String]
    def report
      puts "Output: #{@x},#{@y},#{@direction.current}"
    end

    # @param [String] direction
    def rotate(direction)
      @direction = case direction
                   when LEFT
                     @direction.left
                   when RIGHT
                     @direction.right
                   else
                     raise "Invalid direction!"
                   end
      true
    end

    private

    class Direction < Struct.new(:left, :right, :current); end
  end
end
