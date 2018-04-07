require 'gosu'
require 'chipmunk'

class Escape < Gosu::Window

  DAMPING = 0.90
  GRAVITY = 400.0
  attr_reader :space

  def initialize
    super(800, 800)
    self.caption = 'Escape'
    @game_over = false
    @space = CP::Space.new
    @background = Gosu::Image.new('images/background.png', tileable: true)
    @space.damping = DAMPING
    @space.gravity = CP::Vec2.new(0, 0, GRAVITY)
  end

  def update
    unless @game_over
      10.times do
        @space.step(1.0/600)
      end
    end
  end

end

window = Escape.new
window.show
