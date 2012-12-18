package de.eiszfuchs.game.arrowmania {
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	/**
	 * @author eiszfuchs
	 */
	public class Game extends Sprite {

		private var points:int;
		private var emitCount:int;

		private var arrows:Array;
		
		private var tick:int;
		private var tickStep:int;
		private var tickLengthBase:int;
		private var tickLength:int;
		private var tickDecrease:int;

		private var speed:int;
		private var speedStep:Number;
		private var speedIncrease:int;

		private var mocking:Boolean;
		private var mockStart:int;
		private var mockPosition:Boolean;
		private var mockDirection:Boolean;

		public function Game():void {
			this.init();
		}

		public static const UP:int = 0;
		public static const RIGHT:int = 3;
		public static const DOWN:int = 1;
		public static const LEFT:int = 2;

		public static const WHITE:uint = 0xffffff;
		public static const RED:uint = 0xff0000;
		public static const GREEN:uint = 0x00ff00;
		public static const BLUE:uint = 0x0000ff;
		public static const YELLOW:uint = 0xffff00;
		
		private function init(e:Event = null):void {
			build();

			this.tick = 1;
			this.tickLengthBase = 60;
			this.tickLength = this.tickLengthBase;
			this.tickStep = 1;
			this.tickDecrease = 10;

			this.speed = 1;
			this.speedStep = 0.5;
			this.speedIncrease = 100;

			this.mockPosition = false;
			this.mockDirection = false;
			this.mocking = false;
			this.mockStart = 100;

			this.points = 0;
			this.arrows = new Array;
			this.emitCount = this.arrows.length;

			this.addEventListener(Event.ENTER_FRAME, this.update);
			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private var scoreFormat:TextFormat;
		private var scoreField:TextField;
		private function build():void {
			scoreFormat = new TextFormat;
			scoreFormat.font = "Helvetica";
			scoreFormat.size = 20;
			scoreField = new TextField;
			scoreField.type = TextFieldType.DYNAMIC;
			scoreField.textColor = 0xffffff;
			scoreField.embedFonts = false;
			scoreField.mouseEnabled = false;
			scoreField.selectable = false;
			scoreField.autoSize = TextFieldAutoSize.LEFT;
			scoreField.defaultTextFormat = this.scoreFormat;
			scoreField.text = "0";

			addChild(scoreField);
		}

		private function update(event:Event = null):void {
			if (tick === 1) {
				var dir:int = this.randomDirection();
				this.emit(dir, dir, dir, WHITE, false);
			}

			for (var i:int = 0; i < this.arrows.length; i += 1) {
				this.arrows[i].y -= this.speed;
			}

			if (this.emitCount > 0) {
				this.tickLength = this.tickLengthBase - this.tickStep * Math.floor(this.emitCount / this.tickDecrease);
			}

			tick += 1;
			if (tick > this.tickLength) {
				tick = 1;
			}

			if (this.emitCount >= this.mockStart) {
				this.mocking = true;
			}

			scoreField.text = this.points.toString(10);
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
			} else {
				this.die();
			}

			this.update();
		}

		private function randomDirection():int {
			return Math.floor(Math.random() * 4);
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

		private function die():void {
			this.removeEventListener(Event.ENTER_FRAME, this.update);
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);

			// end of game
		}
	}
}
