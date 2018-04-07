require_relative 'square'

class Game

  def initialize(window)
    @window = window
    @squares = []
    color_list = []

    # push each color 12 times in the color_list array
    [:red, :green, :blue].each do |color|
      12.times do
        color_list.push color
      end
    end

    # shiffle colors and create a grid
    color_list.shuffle!
    (0..5).each do |row|
      (0..5).each do |column|
        index = row * 6 + column
        @squares.push(Square.new(@window, column, row, color_list[index]))
      end
    end

    @font = Gosu::Font.new(36)
  end

  def draw
    @squares.each do |square|
      square.draw
    end
  end

end
