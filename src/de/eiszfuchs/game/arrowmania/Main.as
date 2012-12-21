package de.eiszfuchs.game.arrowmania {

	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;

	/**
	 * @author eiszfuchs
	 */
	public class Main extends Sprite {

		public static var master:Main;

		public function Main():void {
			if (stage)
				this.init();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		// possible arrows as of arrow mania II:
		// (! = opposite)
		// - direction = key
		// - position = key
		// - flashing ? direction = key : direction = !key
		// - flashing ? position = key : position = !key
		// - flashing ? position = key : direction = key
		// - flashing ? direction = key : position = key
		// - ...

		private function init(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			Main.master = this;

			this.graphics.clear();
			this.graphics.beginFill(Game.WHITE);
			this.graphics.drawRect(0, 0, 150, 420);
			this.graphics.endFill();

			this.addChild(new Menu);
		}

		/*

		TODO

		*/
	}
}
