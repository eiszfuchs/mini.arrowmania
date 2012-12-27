package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Arrow;

	/**
	 * @author eiszfuchs
	 */
	public class Reaction extends Mode {

		public function Reaction():void {
			super();

			this.identifier = "Reaction";
		}

		override public function emit(index:int = 0):Arrow {
			// TODO: stub

			// TODO: catch arrows in a particular area
		}
	}
}
