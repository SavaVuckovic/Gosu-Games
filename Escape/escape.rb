require 'gosu'
require 'chipmunk'
require_relative 'boulder'
require_relative 'platform'

class Escape < Gosu::Window

  DAMPING = 0.90
  GRAVITY = 400.0
  BOULDER_FREQUENCY = 0.01
  attr_reader :space

  def initialize
    super(800, 800)
    self.caption = 'Escape'
    @game_over = false
    @space = CP::Space.new
    @background = Gosu::Image.new('images/background.png', tileable: true)
    @space.damping = DAMPING
    @space.gravity = CP::Vec2.new(0.0, GRAVITY)
    @boulders = []
    @platforms = make_platforms
  end

  def update
    unless @game_over
      10.times do
        @space.step(1.0/600)
      end

      if rand < BOULDER_FREQUENCY
        @boulders.push Boulder.new(self, 200 + rand(400), -20)
      end
    end
  end

  def draw
    @background.draw(0, 0, 0)
    @background.draw(0, 529, 0)
    @boulders.each do |boulder|
      boulder.draw
    end

    @platforms.each do |platform|
      platform.draw
    end
  end

  def make_platforms
    platforms = []
    platforms.push Platform.new(self, 150, 700)
    platforms.push Platform.new(self, 320, 650)
    platforms.push Platform.new(self, 150, 500)
    platforms.push Platform.new(self, 470, 550)
    return platforms
  end

end

window = Escape.new
window.show
