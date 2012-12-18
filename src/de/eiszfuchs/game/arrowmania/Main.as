package de.eiszfuchs.game.arrowmania {
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	/**
	 * @author eiszfuchs
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage)
				this.init();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			this.graphics.clear();
			this.graphics.beginFill(0xff2277);
			this.graphics.drawRect(0, 0, 150, 420);
			this.graphics.endFill();

			this.addEventListener(Event.ENTER_FRAME, this.update);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private var tick:int = 1;
		private function update(event:Event = null):void {
			if (tick === 1) {
				var dir:int = this.randomDirection();
				this.emit(dir, dir, dir, WHITE, false);
			}

			tick += 1;
			if (tick > 60) {
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
			}
		}

		private function randomDirection():int {
			return Math.floor(Math.random() * 4);
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

		private var arrows:Array = new Array;

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
	}
}
