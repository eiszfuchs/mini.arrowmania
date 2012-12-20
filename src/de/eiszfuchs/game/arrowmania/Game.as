package de.eiszfuchs.game.arrowmania {
	
	import flash.display.Sprite;
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

		private var mocking:Boolean;
		private var mockStart:int;
		private var mockPosition:Boolean;
		private var mockDirection:Boolean;

		public function Game(mode:Mode):void {
			this.init(mode);
		}

		public static const UP:int = 0;
		public static const RIGHT:int = 3;
		public static const DOWN:int = 1;
		public static const LEFT:int = 2;

		public static const WHITE:uint = 0xffffff;
		public static const RED:uint = 0xff2277;
		public static const GREEN:uint = 0x81db50;
		public static const BLUE:uint = 0x2c5cf7;
		public static const YELLOW:uint = 0xe6e668;
		
		private function init(mode:Mode):void {
			build();

			this.tick = 1;
			this.tickLengthBase = mode.tickLength;
			this.tickLengthMin = 5;
			this.tickLength = this.tickLengthBase;
			this.tickStep = 1;
			this.tickDecrease = mode.tickDecrease;

			this.speedBase = mode.speed;
			this.speed = this.speedBase;
			this.speedStep = mode.speedStep;
			this.speedIncrease = mode.speedIncrease;

			this.mockPosition = mode.mockPosition;
			this.mockDirection = mode.mockDirection;
			this.mocking = false;
			this.mockStart = mode.mockStart;

			this.points = 0;
			this.arrows = new Array;
			this.emitCount = this.arrows.length;

			this.addEventListener(Event.ENTER_FRAME, this.updateTick);
			this.addEventListener(Event.ENTER_FRAME, this.update);
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
		}

		private function updateTick(event:Event = null):void {
			tick += 1;
			if (tick > this.tickLength) {
				tick = 1;
			}
		}

		private function update(event:Event = null):void {
			if (tick === 1) {
				var dir:int = this.randomDirection();
				this.emit(dir, dir, dir, this.randomColor(), true);
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

			if (this.emitCount >= this.mockStart) {
				this.mocking = true;
			}

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
			}

			var arrow:Arrow;
			arrow = this.arrows[0];
			if (arrow.getDirection() === key) {
				arrow = this.arrows.shift();
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

		private function randomIndex():int {
			return Math.floor(Math.random() * 4);
		}

		private function randomDirection():int {
			var directions:Array = [UP, DOWN, LEFT, RIGHT];
			return directions[this.randomIndex()];
		}

		private function randomColor():int {
			var colors:Array = [RED, BLUE, GREEN, YELLOW];
			return colors[this.randomIndex()];
		}

		/**
		 * position  - slot  
		 * direction - arrow direction
		 * target    - which button needs to be pressed
		 * color     - color
		 * flashing  - flashes?
		 */
		private function emit(position:int, direction:int, target:int, color:uint, flashing:Boolean):Arrow {
			var arrow:Arrow = new Arrow(position, direction, target, color, flashing);
				
			arrow.y = this.stage.stageHeight + 10;
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
				this.y = Math.random() * 20 - 10;
			} else {
				this.y = 0;
			}

			this.filters = [
				new BlurFilter(Math.random() * 10, 0, 2)
			];
		}

		private function die():void {
			this.removeEventListener(Event.ENTER_FRAME, this.update);
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);

			scoreFormat.size = 56;
			scoreField.text = this.points.toString(10);
			scoreField.setTextFormat(scoreFormat);
			scoreField.x = 10;

			// this.rotation = 5;

			this.addEventListener(Event.ENTER_FRAME, this.noise);

			// end of game
		}
	}
}
