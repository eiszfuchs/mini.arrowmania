package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Reaction extends Mode {

		public function Reaction():void {
			super();

			this.tickLength = 8;
			this.speed = 4;

			this.tickStep = 0;
			this.speedStep = 0;

			this.catchAbove = 420;
			this.catchBelow = 20;

			this.identifier = "Reaction";
		}

		override public function emit(index:int = 0):Arrow {
			if (Math.random() > 0.8) return null;

			var offset:int = this.randomIndex();

			var position:int = this.getDirection(offset);
			var direction:int = this.getDirection(offset);
			var target:int = this.getDirection(offset);
			var color:uint = this.getColor(offset);
			var flashing:Boolean = false;

			return new Arrow(position, direction, target, color, flashing);
		}
	}
}
