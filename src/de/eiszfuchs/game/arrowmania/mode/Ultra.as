package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Ultra extends Normal {

		public function Ultra():void {
			super();

			this.speed = 3;
			this.tickLength = 24;
			this.speedIncrease = 8;
			this.tickDecrease = 8;

			this.identifier = "Ultra";
		}
	}
}
