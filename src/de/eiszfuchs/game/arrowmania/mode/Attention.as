package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Game;
	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Attention extends Mode {

		public function Attention():void {
			super();

			this.speed = 0.8;
			this.tickLength = 80;
		}

		override public function emit(index:int = 0):Arrow {
			var direction:int = this.randomDirection();
			var slot:int = this.randomDirection();

			var color:uint = this.randomColor();
			var flashing:Boolean = Math.random() > 0.5;

			var target:int = 0;
			if (flashing) {
				target = slot;
			} else {
				target = direction;
			}

			return new Arrow(slot, direction, target, color, flashing);
		}
	}
}
