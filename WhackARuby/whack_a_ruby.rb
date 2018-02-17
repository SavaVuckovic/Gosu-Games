require 'gosu'

class WhackARuby < Gosu::Window

  SCREEN_WIDTH = 800
  SCREEN_HEIGHT = 600

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Whack a Ruby!'
    @ruby = Gosu::Image.new('ruby.png')
    @hammer = Gosu::Image.new('hammer.png')
    @x = 300
    @y = 300
    @width = 50
    @height = 43
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hit = 0
  end

  def button_down(id)
    if id == Gosu::MsLeft
      if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
        @hit = 1
      else
        @hit = -1
      end
    end
  end

  def update
    @x += @velocity_x
    @y += @velocity_y

    @velocity_x *= -1 if @x + @width/2 > 800 || @x - @width/2 < 0
    @velocity_y *= -1 if @y + @height/2 > 600 || @y - @height/2 < 0

    @visible -= 1
    @visible = 50 if @visible < -10 && rand < 0.01
  end

  def draw
    if @visible > 0
      @ruby.draw(@x - @width/2, @y - @height/2, 1)
    end

    @hammer.draw(mouse_x - 25, mouse_y - 25, 1)

    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
  end

end


window = WhackARuby.new
window.show
