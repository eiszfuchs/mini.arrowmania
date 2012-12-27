package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Nostalgic extends Mode {

		public function Nostalgic():void {
			super();

			this.tickLength = 40;
			this.speed = 1.4;

			this.tickStep = 0;
			this.speedStep = 0;

			this.catchAbove = 40;
			this.catchBelow = 20;

			this.identifier = "Nostalgic";
		}
	}
}
