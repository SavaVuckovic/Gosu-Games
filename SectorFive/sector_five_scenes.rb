require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

class SectorFive < Gosu::Window

	SCREEN_WIDTH = 1200
	SCREEN_HEIGHT = 900
	ENEMY_FREQUENCY = 0.05

	def initialize
		super(SCREEN_WIDTH, SCREEN_HEIGHT)
		self.caption = "Sector Five"
		@background_image = Gosu::Image.new('images/start_screen.jpg')
		@scene = :start
	end

	def initialize_game
		@player = Player.new(self)
		@enemies = []
		@bullets = []
		@explosions = []
		@scene = :game
	end

	def draw
		case @scene
			when :start then draw_start
			when :game then draw_game
			when :end then draw_end
		end
	end

	def draw_start
		@background_image.draw(0, 0, 0)
	end

	def draw_game
		@player.draw

		@enemies.each do |enemy|
			enemy.draw
		end

		@bullets.each do |bullet|
			bullet.draw
		end

		@explosions.each do |explosion|
			explosion.draw
		end
	end

	def update
		case @scene
			when :game then update_game
			when :end then update_end
		end
	end

	def update_game
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

    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        if distance < enemy.radius + bullet.radius
          @enemies.delete(enemy)
          @bullets.delete(bullet)
          @explosions.push(Explosion.new(self, enemy.x, enemy.y))
        end
      end
    end

    @explosions.dup.each do |explosion|
      @explosions.delete explosion if explosion.finished
    end

    @enemies.dup.each do |enemy|
      if enemy.y > SCREEN_HEIGHT + enemy.radius
        @enemies.delete enemy
      end
    end

    @bullets.dup.each do |bullet|
      @bullets.delete bullet unless bullet.onscreen?
    end
	end

	def button_down(id)
		case @scene
			when :start then button_down_start(id)
			when :game then button_down_game(id)
			when :end then button_down_end(id)
		end
	end

	def button_down_start(id)
		initialize_game
	end

	def button_down_game(id)
		if id == Gosu::KbSpace
      @bullets.push(Bullet.new(self, @player.x, @player.y, @player.angle))
    end
	end

end

window = SectorFive.new
window.show