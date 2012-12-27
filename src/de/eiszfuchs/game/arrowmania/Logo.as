package de.eiszfuchs.game.arrowmania {

	import flash.display.Sprite;
	import flash.events.*;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	/**
	 * @author eiszfuchs
	 */
	public class Logo extends Noisy {

		public function Logo():void {
			var logoFormat:TextFormat;
			var logoField:TextField;

			logoFormat = new TextFormat;
			logoFormat.font = "News Cycle Bold";
			logoFormat.size = 22;
			logoField = new TextField;
			logoField.type = TextFieldType.DYNAMIC;
			logoField.textColor = Game.RED;
			logoField.embedFonts = true;
			logoField.mouseEnabled = false;
			logoField.selectable = false;
			logoField.autoSize = TextFieldAutoSize.LEFT;
			logoField.defaultTextFormat = logoFormat;
			logoField.text = "Arrow Mania III";

			logoField.x = (150 - logoField.width) / 2;
			logoField.y = 5;

			addChild(logoField);

			this.addEventListener(Event.ENTER_FRAME, this.noise);
		}
	}
}
