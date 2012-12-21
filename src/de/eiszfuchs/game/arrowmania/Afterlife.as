package de.eiszfuchs.game.arrowmania {

	import flash.display.Sprite;
	import flash.events.Event;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	/**
	 * @author eiszfuchs
	 */
	public class Afterlife extends Sprite {

		private var tick:int = 0;

		public function Afterlife(message:String) {
			this.addEventListener(Event.ENTER_FRAME, this.update);

			draw(message);
		}

		private function draw(message:String):void {
			var deathFormat:TextFormat;
			var deathField:TextField;

			deathFormat = new TextFormat;
			deathFormat.font = "News Cycle Bold";
			deathFormat.size = 12;
			deathField = new TextField;
			deathField.type = TextFieldType.DYNAMIC;
			deathField.textColor = Game.SLOT;
			deathField.embedFonts = true;
			deathField.mouseEnabled = false;
			deathField.selectable = false;
			deathField.autoSize = TextFieldAutoSize.LEFT;
			deathField.defaultTextFormat = deathFormat;
			deathField.text = message;

			deathField.x -= deathField.width / 2;

			this.addChild(deathField);
		}

		private function update(event:Event = null):void {
			var fadeLength:int = 35;

			this.tick += 1;
			this.y -= 0.5;

			this.alpha = (fadeLength - tick) / fadeLength;

			if (this.tick > fadeLength) {
				this.die();
			}
		}

		private function die():void {
			this.removeEventListener(Event.ENTER_FRAME, this.update);
			this.parent.removeChild(this);
		}
	}
}
