package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Ultra extends Normal {

		public function Ultra():void {
			super();

			this.speed = 2;
			this.tickLength = 24;
			speedIncrease = 8;
			tickDecrease = 8;
		}
	}
}
