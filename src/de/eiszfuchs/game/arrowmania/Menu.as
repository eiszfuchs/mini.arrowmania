package de.eiszfuchs.game.arrowmania {

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import de.eiszfuchs.game.arrowmania.mode.*;

	/**
	 * @author eiszfuchs
	 */
	public class Menu extends Sprite {

		public function Menu():void {
			this.live();
		}

		private function react(event:KeyboardEvent):void {
			var key:uint = event.keyCode;

			switch (key) {
				case Keyboard.NUMBER_1:
					addChild(new Game(new Normal));
					this.die();
					break;
				case Keyboard.NUMBER_2:
					addChild(new Game(new Kickstart));
					this.die();
					break;
			}
		}

		private function live():void {
			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private function die():void {
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}
	}
}
