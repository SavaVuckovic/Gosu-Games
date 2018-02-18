require 'gosu'
require_relative 'player'

class SectorFive < Gosu::Window

  SCREEN_WIDTH = 1200
  SCREEN_HEIGHT = 900

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Sector Five'

    @player = Player.new(self)
  end

  def draw
    @player.draw
  end

end


window = SectorFive.new
window.show
