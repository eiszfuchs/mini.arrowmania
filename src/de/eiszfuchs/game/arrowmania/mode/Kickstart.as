package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Kickstart extends Normal {

		public function Kickstart():void {
			super();

			this.skipArrows = 450;

			this.identifier = "Kickstart";
		}
	}
}
