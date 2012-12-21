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
			deathFormat.font = "Arial";
			deathFormat.size = 12;
			deathFormat.bold = false;
			deathField = new TextField;
			deathField.type = TextFieldType.DYNAMIC;
			deathField.textColor = Game.SLOT;
			deathField.embedFonts = false; // TODO: true
			deathField.mouseEnabled = false;
			deathField.selectable = false;
			deathField.autoSize = TextFieldAutoSize.LEFT;
			deathField.defaultTextFormat = deathFormat;
			deathField.text = message;

			this.addChild(deathField);
		}

		private function update(event:Event = null):void {
			this.tick += 1;
			this.y -= 0.5;

			this.alpha = (30 - tick) / 30;

			if (this.tick > 30) {
				this.die();
			}
		}

		private function die():void {
			this.removeEventListener(Event.ENTER_FRAME, this.update);
			this.parent.removeChild(this);
		}
	}
}
