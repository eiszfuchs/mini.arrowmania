package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Fooling extends Mode {

		public function Fooling():void {
			super();
		}

		override public function emit(index:int = 0):Arrow {
			var offset:int = this.randomIndex();
			var direction:int = this.getDirection(offset);
			var color:uint = this.getColor(offset);

			var slot:int;
			if (Math.random() > 0.95) {
				slot = this.randomDirection();
			} else {
				slot = direction;
			}

			return new Arrow(slot, direction, direction, color, true);
		}
	}
}