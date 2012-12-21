package de.eiszfuchs.game.arrowmania {

	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import de.eiszfuchs.game.arrowmania.mode.*;

	/**
	 * @author eiszfuchs
	 */
	public class Menu extends Sprite {

		private var classes:Array = new Array;
		private var labels:Array = new Array;
		private var descriptions:Array = new Array;

		private var select:int = 0;

		public function Menu():void {
			this.classes = [Normal, Kickstart, Ultra, Fooling, Crazy, Attention];
			this.labels = ["Normal", "Kickstart", "Ultra", "Fooling", "Crazy", "Attention"];
			this.descriptions = ["Normal", "Kickstart", "Ultra", "Fooling", "Crazy", "Attention"];

			this.live();
		}

		private function react(event:KeyboardEvent):void {
			var key:uint = event.keyCode;

			switch (key) {
				case Keyboard.UP:
					this.select -= 1;
					break;
				case Keyboard.DOWN:
					this.select += 1;
					break;
				case Keyboard.ENTER:
					this.parent.addChild(new Game(new this.classes[this.select]));
					this.die();
					break;
			}

			if (this.select < 0) {
				this.select = this.classes.length - 1;
			} else if (this.select >= this.classes.length) {
				this.select = 0;
			}

			this.draw();
		}

		private function build():void {
			for (var i:int = 0; i < this.classes.length; i += 1) {
				var selectFormat:TextFormat;
				var selectField:TextField;

				selectFormat = new TextFormat;
				selectFormat.font = "Arial";
				selectFormat.size = 16;
				selectFormat.bold = true;
				selectField = new TextField;
				selectField.type = TextFieldType.DYNAMIC;
				selectField.textColor = Game.RED;
				selectField.embedFonts = false; // TODO: true
				selectField.mouseEnabled = false;
				selectField.selectable = false;
				selectField.autoSize = TextFieldAutoSize.LEFT;
				selectField.defaultTextFormat = selectFormat;
				selectField.text = this.labels[i];

				selectField.x = 40;
				selectField.y = 20 + i * 30;

				this.addChild(selectField);
			}
		}

		private function draw():void {
			var g:Graphics = this.graphics;

			g.clear();
			g.beginFill(Game.SLOT);
			Arrow.shape(g, 20, 30 + this.select * 30);
			g.endFill();
		}

		private function live():void {
			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);

			this.build();
			this.draw();
		}

		private function die():void {
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);

			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}
