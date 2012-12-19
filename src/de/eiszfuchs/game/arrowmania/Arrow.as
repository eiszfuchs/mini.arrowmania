package de.eiszfuchs.game.arrowmania {
	
	import flash.display.Sprite;
	import flash.display.Graphics;

	import flash.events.Event;
	
	/**
	 * @author eiszfuchs
	 */
	public class Arrow extends Sprite {
		
		private var position:int;
		private var direction:int;
		private var target:int;
		private var color:uint;
		private var flashing:Boolean;

		public function Arrow(position:int, direction:int, target:int, color:uint, flashing:Boolean) {
			this.position = position;
			this.direction = direction;
			this.target = target;
			this.color = color;
			this.flashing = flashing;

			this.x = (position + 1) * 30;

			this.draw();
		}

		private function shape(g:Graphics):void {
			g.moveTo(0, -10);
			g.lineTo(-10, 10);
			g.lineTo(0, 5);
			g.lineTo(10, 10);
			g.lineTo(0, -10);
		}

		private function draw():void {
			var g:Graphics = this.graphics;

			g.clear();
			g.beginFill(this.color);
			this.shape(g);
			g.endFill();

			switch (this.direction) {
				case Game.UP:
					this.rotation = 0;
					break;
				case Game.DOWN:
					this.rotation = 180;
					break;
				case Game.LEFT:
					this.rotation = 270;
					break;
				case Game.RIGHT:
					this.rotation = 90;
					break;
			}
		}

		public function update(tick:int, tickLength:int):void {
			this.draw();

			if (this.flashing) {
				var g:Graphics = this.graphics;

				g.lineStyle(0, 0x000000, Math.abs(tick / (tickLength / 2) - 1), true);
				this.shape(g);
			}
		}

		public function getDirection():int {
			return this.target; // yes!
		}

		public function kill():void {
			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}
