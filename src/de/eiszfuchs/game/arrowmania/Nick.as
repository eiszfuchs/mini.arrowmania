package de.eiszfuchs.game.arrowmania {

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.*;
	import flash.ui.Keyboard;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import de.eiszfuchs.utils.*;

	/**
	 * @author eiszfuchs
	 */
	public class Nick extends Noisy {

		public function Nick():void {
			this.init();

			this.addEventListener(Event.ENTER_FRAME, this.noise);
			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private function init():void {
			build();
		}

		private var nickFormat:TextFormat;
		private var nickField:TextField;
		private function build():void {
			nickFormat = new TextFormat;
			nickFormat.font = "News Cycle Bold";
			nickFormat.size = 32;
			nickField = new TextField;
			nickField.type = TextFieldType.INPUT;
			nickField.restrict = "A-Za-z0-9";
			nickField.borderColor = Game.SLOT;
			nickField.textColor = Game.RED;
			nickField.border = true;
			nickField.embedFonts = true;
			nickField.mouseEnabled = true;
			nickField.selectable = true;
			nickField.width = 130;
			nickField.defaultTextFormat = this.nickFormat;
			nickField.text = Settings.getSetting('player_nick', "Player");

			nickField.x = 10;
			nickField.y = 10;

			addChild(nickField);
		}

		private function react(event:KeyboardEvent = null):void {
			var key:uint = event.keyCode;

			switch (key) {
				case Keyboard.ENTER:
					Settings.setSetting('player_nick', this.nickField.text);
				case Keyboard.ESCAPE:
					if (this.parent) {
						this.parent.addChild(new Menu);
					}
					this.kill();
			}
		}

		private function kill():void {
			this.removeEventListener(Event.ENTER_FRAME, this.noise);
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);

			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}
