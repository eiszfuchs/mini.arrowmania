package de.eiszfuchs.game.arrowmania {
	
	import flash.display.DisplayObject;
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

		public static function shape(g:Graphics, shiftX:int = 0, shiftY:int = 0):void {
			g.moveTo(shiftX + 0,   shiftY + -10);
			g.lineTo(shiftX + -10, shiftY + 10);
			g.lineTo(shiftX + 0,   shiftY + 5);
			g.lineTo(shiftX + 10,  shiftY + 10);
			g.lineTo(shiftX + 0,   shiftY + -10);
		}

		public static function rotate(d:DisplayObject, direction:int):void {
			switch (direction) {
				case Game.UP:
					d.rotation = 0;
					break;
				case Game.RIGHT:
					d.rotation = 90;
					break;
				case Game.DOWN:
					d.rotation = 180;
					break;
				case Game.LEFT:
					d.rotation = 270;
					break;
			}
		}

		private function draw():void {
			var g:Graphics = this.graphics;

			g.clear();
			g.beginFill(this.color);
			Arrow.shape(g);
			g.endFill();

			Arrow.rotate(this, this.direction);
		}

		public function update(tick:int, tickLength:int):void {
			this.draw();

			if (this.flashing) {
				var g:Graphics = this.graphics;

				g.lineStyle(0, 0x000000, Math.abs(tick / (tickLength / 2) - 1), true);
				Arrow.shape(g);
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
