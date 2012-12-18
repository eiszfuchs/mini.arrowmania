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

		private function draw():void {
			var g:Graphics = this.graphics;

			g.clear();

			g.beginFill(this.color);
			switch (this.direction) {
				case Game.UP:
					g.moveTo(0, -10);
					g.lineTo(-10, 10);
					g.lineTo(10, 10);
					break;
				case Game.DOWN:
					g.moveTo(0, 10);
					g.lineTo(-10, -10);
					g.lineTo(10, -10);
					break;
				case Game.LEFT:
					g.moveTo(-10, 0);
					g.lineTo(10, 10);
					g.lineTo(10, -10);
					break;
				case Game.RIGHT:
					g.moveTo(10, 0);
					g.lineTo(-10, 10);
					g.lineTo(-10, -10);
					break;
			}
			g.endFill();
		}

		public function getDirection():int {
			return this.direction;
		}

		public function kill():void {
			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}
