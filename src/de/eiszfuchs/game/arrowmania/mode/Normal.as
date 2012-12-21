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
			var direction:int = this.getDirection(offset);
			var color:uint = this.getColor(offset);
			return new Arrow(direction, direction, direction, color, true);
		}
	}
}
