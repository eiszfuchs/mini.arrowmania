package de.eiszfuchs.game.arrowmania {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @author eiszfuchs
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			addEventListener(Event.ENTER_FRAME, this.update);
		}

		private var tick:int = 1;
		private function update(event:Event = null):void {
			if (tick === 1) {
				var dir:int = this.randomDirection();
				var arrow:Arrow = this.emit(dir, dir, dir, RED, false);	
				arrow.y = this.stage.stageHeight;
				this.addChild(arrow);
			}

			tick += 1;
			if (tick > 60) {
				tick = 1;
			}
		}

		private function randomDirection():int {
			return Math.floor(Math.random() * 4);
		}

		public static const UP:int = 0;
		public static const RIGHT:int = 1;
		public static const DOWN:int = 2;
		public static const LEFT:int = 3;

		public static const RED:uint = 0xff0000;
		public static const GREEN:uint = 0x00ff00;
		public static const BLUE:uint = 0x0000ff;
		public static const YELLOW:uint = 0xffff00;

		/**
		 * position
		 * direction
		 * target
		 * color
		 * flashing
		 */
		private function emit(position:int, direction:int, target:int, color:uint, flashing:Boolean):Arrow {
			return new Arrow(position, direction, target, color, flashing);
		}
	}
}
