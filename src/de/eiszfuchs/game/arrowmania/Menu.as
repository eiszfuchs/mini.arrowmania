package de.eiszfuchs.game.arrowmania {

	import flash.display.Sprite;

	import de.eiszfuchs.game.arrowmania.mode.*;

	/**
	 * @author eiszfuchs
	 */
	public class Menu extends Sprite {

		public function Menu():void {
			addChild(new Game(new Mode));
		}
	}
}
