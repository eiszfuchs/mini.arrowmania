package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Extreme extends Normal {

		public function Extreme():void {
			super();

			this.speed = 4;
			this.tickLength = 22;
			this.speedIncrease = 6;
			this.tickDecrease = 6;

			this.identifier = "Extreme";
		}
	}
}
