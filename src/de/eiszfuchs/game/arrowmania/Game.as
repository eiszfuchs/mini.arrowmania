package de.eiszfuchs.game.arrowmania {
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	/**
	 * @author eiszfuchs
	 */
	public class Game extends Sprite {

		private var points:int;

		private var arrows:Array;
		
		private var tick:int;
		private var tickLength:int;

		private var speed:int;

		private var mockPosition:Boolean;
		private var mockDirection:Boolean;

		public function Game():void {
			this.init();
		}

		public static const UP:int = 0;
		public static const RIGHT:int = 1;
		public static const DOWN:int = 2;
		public static const LEFT:int = 3;

		public static const WHITE:uint = 0xffffff;
		public static const RED:uint = 0xff0000;
		public static const GREEN:uint = 0x00ff00;
		public static const BLUE:uint = 0x0000ff;
		public static const YELLOW:uint = 0xffff00;
		
		private function init(e:Event = null):void {
			this.tick = 1;
			this.tickLength = 60;

			this.speed = 1;

			this.mockPosition = false;
			this.mockDirection = false;

			this.points = 0;
			this.arrows = new Array;

			this.addEventListener(Event.ENTER_FRAME, this.update);
			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private function update(event:Event = null):void {
			if (tick === 1) {
				var dir:int = this.randomDirection();
				this.emit(dir, dir, dir, WHITE, false);
			}

			for (var i:int = 0; i < this.arrows.length; i += 1) {
				this.arrows[i].y -= this.speed;
			}

			tick += 1;
			if (tick > this.tickLength) {
				tick = 1;
			}
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

			return arrow;
		}

		private function die():void {
			this.removeEventListener(Event.ENTER_FRAME, this.update);
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);
			
			// end of game
		}
	}
}
