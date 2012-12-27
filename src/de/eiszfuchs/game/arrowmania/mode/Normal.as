package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Normal extends Mode {

		public function Normal():void {
			super();

			this.identifier = "Normal";
		}

		override public function emit(index:int = 0):Arrow {
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
