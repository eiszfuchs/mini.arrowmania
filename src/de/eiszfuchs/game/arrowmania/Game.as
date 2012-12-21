package de.eiszfuchs.game.arrowmania {

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.*;
	import flash.ui.Keyboard;

	import flash.filters.*;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import de.eiszfuchs.game.arrowmania.mode.*;

	/**
	 * @author eiszfuchs
	 */
	public class Game extends Sprite {

		private var points:int;
		private var emitCount:int;

		private var arrows:Array;

		private var tick:int;
		private var tickStep:int;
		private var tickLengthMin:int;
		private var tickLengthBase:int;
		private var tickLength:int;
		private var tickDecrease:int;

		private var speed:Number;
		private var speedBase:Number;
		private var speedStep:Number;
		private var speedIncrease:int;

		private var mode:Mode;

		public function Game(mode:Mode):void {
			this.mode = mode;

			this.init();
		}

		public static const UP:int = 1;
		public static const RIGHT:int = 3;
		public static const DOWN:int = 2;
		public static const LEFT:int = 0;

		public static const WHITE:uint = 0xffffff;
		public static const SLOT:uint = 0xb5b5b5;
		public static const RED:uint = 0xff2277;
		public static const GREEN:uint = 0x81db50;
		public static const BLUE:uint = 0x2c5cf7;
		public static const YELLOW:uint = 0xe6e668;

		private function init():void {
			build();

			this.tick = 1;
			this.tickLengthBase = this.mode.tickLength;
			this.tickLengthMin = 5;
			this.tickLength = this.tickLengthBase;
			this.tickStep = 1;
			this.tickDecrease = this.mode.tickDecrease;

			this.speedBase = this.mode.speed;
			this.speed = this.speedBase;
			this.speedStep = this.mode.speedStep;
			this.speedIncrease = this.mode.speedIncrease;

			this.points = 0;
			this.arrows = new Array;
			this.emitCount = this.arrows.length;

			this.addEventListener(Event.ENTER_FRAME, this.update);
			this.addEventListener(Event.ENTER_FRAME, this.updateTick);
			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private var scoreFormat:TextFormat;
		private var scoreField:TextField;
		private function build():void {
			scoreFormat = new TextFormat;
			scoreFormat.font = "Arial";
			scoreFormat.size = 16;
			scoreFormat.bold = true;
			scoreField = new TextField;
			scoreField.type = TextFieldType.DYNAMIC;
			scoreField.textColor = RED;
			scoreField.embedFonts = false; // TODO: true
			scoreField.mouseEnabled = false;
			scoreField.selectable = false;
			scoreField.autoSize = TextFieldAutoSize.LEFT;
			scoreField.defaultTextFormat = this.scoreFormat;
			scoreField.text = "0";

			addChild(scoreField);

			// slot arrows
			for (var i:int = 0; i < 4; i += 1) {
				var slotShape:Shape = new Shape;

				var g:Graphics = slotShape.graphics;
				g.clear();
				g.beginFill(SLOT);
				Arrow.shape(g);
				g.endFill();

				slotShape.x = (i + 1) * 30;
				slotShape.y = Main.master.stage.stageHeight - 30;
				Arrow.rotate(slotShape, i);
				this.addChild(slotShape);
			}
		}

		private function updateTick(event:Event = null):void {
			tick += 1;
			if (tick > this.tickLength) {
				tick = 1;
			}
		}

		private function update(event:Event = null):void {
			if (tick === 1) {
				this.emit();
			}

			for (var i:int = 0; i < this.arrows.length; i += 1) {
				this.arrows[i].y -= this.speed;
				this.arrows[i].update(this.tick, this.tickLength);
			}

			this.tickLength = this.tickLengthBase - this.tickStep * Math.floor(this.emitCount / this.tickDecrease);
			this.tickLength = Math.max(this.tickLength, this.tickLengthMin);
			this.speed = this.speedBase + this.speedStep * Math.floor(this.emitCount / this.speedIncrease);

			// clean up numbers
			this.tickLength = Math.round(this.tickLength * 100) / 100;
			this.speed = Math.round(this.speed * 100) / 100;

			scoreField.text = this.points.toString(10)
				+ "\n" + this.emitCount.toString(10)
				+ "\n" + this.speed.toString(10)
				+ "\n" + this.tick.toString(10)
				+ "\n" + this.tickLength.toString(10);
		}

		private function react(event:KeyboardEvent = null):void {
			var key:uint = event.keyCode;

			switch (key) {
				case Keyboard.UP:
					key = UP;
					break;
				case Keyboard.RIGHT:
					key = RIGHT;
					break;
				case Keyboard.DOWN:
					key = DOWN;
					break;
				case Keyboard.LEFT:
					key = LEFT;
					break;
				case Keyboard.ENTER:
					this.restart();
					return;
				case Keyboard.ESCAPE:
					this.kill();
					return;
			}

			var arrow:Arrow;
			arrow = this.arrows.shift();
			if (arrow.getDirection() === key) {
				arrow.kill();

				this.points += 1;

				if (this.arrows.length < 1) {
					// livin' on the edge!
					// this.tick = 1;
				}
			} else {
				this.die();
			}
		}

		/**
		 * position  - slot
		 * direction - arrow direction
		 * target    - which button needs to be pressed
		 * color     - color
		 * flashing  - flashes?
		 */
		private function emit():Arrow {
			var arrow:Arrow = this.mode.emit(this.emitCount);

			arrow.y = this.stage.stageHeight - 30;
			this.addChild(arrow);

			this.arrows.push(arrow);

			this.emitCount += 1;

			return arrow;
		}

		private function noise(event:Event = null):void {
			if (Math.random() > 0.9) {
				this.x = Math.random() * 10 - 5;
			} else {
				this.x = 0;
			}

			if (Math.random() > 0.95) {
				this.y = Math.random() * 40 - 20;
			} else {
				this.y = 0;
			}

			this.filters = [
				new BlurFilter(Math.random() * 10, 0, 2)
			];
		}

		private function die():void {
			this.removeEventListener(Event.ENTER_FRAME, this.update);

			this.mode.highscore = Math.max(this.points, this.mode.highscore);

			scoreFormat.size = 56;
			scoreField.text = this.points.toString(10) + "\n(high: " + this.mode.highscore.toString(10) + ")\n[ENTER]\n[ESC]";
			scoreField.setTextFormat(scoreFormat, 0, this.points.toString(10).length);
			scoreField.x = 10;

			// this.rotation = 5;

			this.addEventListener(Event.ENTER_FRAME, this.noise);

			// end of game
		}

		private function restart():void {
			this.parent.addChild(new Game(this.mode));
			this.kill();
		}

		private function kill():void {
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);
			this.removeEventListener(Event.ENTER_FRAME, this.updateTick);
			this.removeEventListener(Event.ENTER_FRAME, this.noise);

			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}
