package de.eiszfuchs.game.arrowmania {

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;

	import de.eiszfuchs.utils.*;

	/**
	 * @author eiszfuchs
	 */
	public class Main extends Sprite {

		public static var master:Main;

		// http://openfontlibrary.org/en/font/news-cycle
		// [Embed(source="/com/fonts/newscycle-regular.ttf", fontFamily="News Cycle Regular", embedAsCFF="false")] public var NEWSCYCLEREGULAR:String;
		[Embed(source="/com/fonts/newscycle-bold.ttf", fontFamily="News Cycle Bold", embedAsCFF="false")] public var NEWSCYCLEBOLD:String;

		public function Main():void {
			if (stage)
				this.init();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			var id:Number = Settings.getSetting('player_id', -1);
			if (id < 0) {
				var now:Date = new Date;
				id = now.getTime() + Math.floor(Math.random() * 1000000);

				Settings.setSetting('player_id', id.toString(36));
			}

			Main.master = this;

			this.graphics.clear();
			this.graphics.beginFill(Game.WHITE);
			this.graphics.drawRect(0, 0, 150, 420);
			this.graphics.endFill();

			this.addChild(new Menu);
		}
	}
}
