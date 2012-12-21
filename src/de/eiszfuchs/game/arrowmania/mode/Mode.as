package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Game;
	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Mode {

		public var tickLength:int;
		public var tickDecrease:int;

		public var speed:Number;
		public var speedStep:Number;
		public var speedIncrease:int;

		public var highscore:int = 0;

		public function Mode():void {
			tickLength = 60;
			tickDecrease = 10;
			speed = 1;
			speedStep = 0.05;
			speedIncrease = 15;
		}

		public function emit(index:int = 0):Arrow {
			var dir:int = this.randomDirection();
			return new Arrow(dir, dir, dir, this.randomColor(), true);
		}

		protected function randomIndex():int {
			return Math.floor(Math.random() * 4);
		}

		protected function getDirection(index:int):int {
			var directions:Array = [Game.UP, Game.DOWN, Game.LEFT, Game.RIGHT];
			return directions[index];
		}

		protected function getColor(index:int):uint {
			var colors:Array = [Game.RED, Game.BLUE, Game.GREEN, Game.YELLOW];
			return colors[index];
		}

		protected function randomDirection():int {
			return this.getDirection(this.randomIndex());
		}

		protected function randomColor():int {
			return this.getColor(this.randomIndex());
		}
	}
}
