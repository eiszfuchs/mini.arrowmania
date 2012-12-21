package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Kickstart extends Normal {

		public function Kickstart():void {
			super();

			this.speed = 1.9;
			this.tickLength = 40;
			speedIncrease = 10;

			this.identifier = "Kickstart";
		}
	}
}
