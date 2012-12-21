package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Game;
	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Crazy extends Mode {

		public function Crazy():void {
			super();

			this.speed = 0.5;
			this.tickLength = 100;
		}

		override public function emit(index:int = 0):Arrow {
			var direction:int = this.randomDirection();
			var slot:int = this.randomDirection();

			var color:uint = (Math.random() > 0.5) ? Game.BLUE : Game.RED;
			var flashing:Boolean = Math.random() > 0.5;

			var target:int = 0;
			if (color == Game.BLUE) {
				target = slot;
			} else {
				target = direction;
			}

			if (flashing) {
				target = this.reverseDirection(target);
			}

			return new Arrow(slot, direction, target, color, flashing);
		}
	}
}
