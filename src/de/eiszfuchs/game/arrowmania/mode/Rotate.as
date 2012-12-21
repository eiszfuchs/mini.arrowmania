package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Rotate extends Mode {

		public function Rotate():void {
			super();

			this.identifier = "Rotate";
		}

		override public function emit(index:int = 0):Arrow {
			var offset:int = this.randomIndex();
			var direction:int = this.getDirection(offset);
			var color:uint = this.getColor(offset);

			var flashing:Boolean = Math.random() > 0.25;
			var target:int = this.rotateDirection(direction, flashing);

			return new Arrow(direction, direction, target, color, flashing);
		}
	}
}
