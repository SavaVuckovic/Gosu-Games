class Player

  def initialize(window)
    @x = 200
    @y = 200
    @angle = 0
    @image = Gosu::Image.new('images/spaceship.png')
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

end
