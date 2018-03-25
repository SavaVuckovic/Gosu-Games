require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

class SectorFive < Gosu::Window

	WIDTH = 800
	HEIGHT = 600
	ENEMY_FREQUENCY = 0.05

	def initialize
		super(WIDTH, HEIGHT)
		self.caption = "Sector Five"
		@background_image = Gosu::Image.new('images/start_screen.jpg')
		@scene = :start
	end

	def draw
		case @scene
			when :start
				draw_start
			when :game
				draw_game
			when :end
				draw_end
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
			when :game
				update_game
			when :end
				update_end
		end
	end
end

window = SectorFive.new
window.show