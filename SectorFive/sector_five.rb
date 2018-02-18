require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'

class SectorFive < Gosu::Window

  SCREEN_WIDTH = 1200
  SCREEN_HEIGHT = 900
  ENEMY_FREQUENCY = 0.02

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.caption = 'Sector Five'

    @player = Player.new(self)
    @enemies = []
    @bullets = []
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push(Bullet.new(self, @player.x, @player.y, @player.angle))
    end
  end

  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move

    if rand < ENEMY_FREQUENCY
      @enemies.push(Enemy.new(self))
    end

    @enemies.each do |enemy|
      enemy.move
    end

    @bullets.each do |bullet|
      bullet.move
    end
  end

  def draw
    @player.draw

    @enemies.each do |enemy|
      enemy.draw
    end

    @bullets.each do |bullet|
      bullet.draw
    end
  end

end


window = SectorFive.new
window.show
