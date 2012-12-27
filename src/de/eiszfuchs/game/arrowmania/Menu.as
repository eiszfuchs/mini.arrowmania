package de.eiszfuchs.game.arrowmania {

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import de.eiszfuchs.utils.*;
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
			this.classes = [Nick, Normal, Kickstart, Ultra, Extreme, Fooling, Crazy, Attention, Rotate, Nostalgic];
			this.labels = ["Change nick", "Normal", "Kickstart", "Ultra", "Extreme", "Fooling", "Crazy", "Attention", "Rotate", "Nostalgic"];
			this.descriptions = [
				"Change your nickname (" + Settings.getSetting('player_nick', "Player") + ") for the high scores.",
				"Normal: Hit the key in the direction of the arrows.",
				"Kickstart: Like 'Normal', but will skip the first 450 arrows.",
				"Ultra: Like 'Normal', but at WAY higher speed.",
				"Extreme: Like 'Ultra', but at EVEN MORE higher speed. (may change)",
				"Fooling: Like 'Normal', but sometimes arrows will come out of the wrong slot.",
				"Crazy: Arrows will appear in blue (press direction of slot) and red (press direction of arrow). If flashing, hit the opposite key.",
				"Attention: If flashing, press direction of slot, otherwise direction of arrow.",
				"Rotate: Press the direction of the arrow, rotated one step clockwise. If flashing, rotate counter-clockwise.",
				"Nostalgic: Catch them if you can."
			];

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
					if (new this.classes[this.select] is Mode) {
						this.parent.addChild(new Game(new this.classes[this.select]));
					} else {
						this.parent.addChild(new this.classes[this.select]);
					}

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

		private function createTextField():TextField {
			var selectFormat:TextFormat;
			var selectField:TextField;

			selectFormat = new TextFormat;
			selectFormat.font = "News Cycle Bold";
			selectFormat.size = 14;
			selectFormat.leading = -4;
			selectField = new TextField;
			selectField.type = TextFieldType.DYNAMIC;
			selectField.textColor = Game.SLOT;
			selectField.embedFonts = true;
			selectField.mouseEnabled = false;
			selectField.selectable = false;
			selectField.autoSize = TextFieldAutoSize.LEFT;
			selectField.defaultTextFormat = selectFormat;

			return selectField;
		}

		private var descriptionField:TextField;
		private var selectionArrow:Shape = new Shape;
		private function build():void {
			this.addChild(new Logo);

			for (var i:int = 0; i < this.classes.length; i += 1) {
				var selectField:TextField = this.createTextField();
				selectField.text = this.labels[i];

				if (new this.classes[i] is Mode) {
					var scoreMode:Mode = new this.classes[i];
					var score:int = (scoreMode).getScore();
					selectField.appendText(" (" + score.toString(10) + ")");
				}

				selectField.x = 40;
				selectField.y = 56 + i * 24;

				this.addChild(selectField);
			}

			this.descriptionField = this.createTextField();
			this.descriptionField.multiline = true;
			this.descriptionField.wordWrap = true;
			this.descriptionField.width = 130;

			this.descriptionField.x = 10;
			this.descriptionField.y = 60 + i * 24;

			this.addChild(this.descriptionField);

			var g:Graphics = this.selectionArrow.graphics;

			g.clear();
			g.beginFill(Game.RED);
			Arrow.shape(g);
			g.endFill();

			Arrow.rotate(this.selectionArrow, Game.RIGHT);

			this.addChild(this.selectionArrow);
		}

		private function draw():void {
			this.selectionArrow.x = 24;
			this.selectionArrow.y = 70 + this.select * 24;

			this.descriptionField.text = this.descriptions[this.select];
		}

		private function live():void {
			this.build();
			this.draw();

			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private function die():void {
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);

			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}
