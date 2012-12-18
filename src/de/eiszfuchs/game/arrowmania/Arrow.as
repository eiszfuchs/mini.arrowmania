package de.eiszfuchs.game.arrowmania {
	
	import flash.display.Sprite;
	import flash.display.Graphics;
	
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

			this.draw();
		}

		private function draw():void {
			var g:Graphics = this.graphics;

			g.clear();

			g.beginFill(this.color);
			if (this.direction === Main.UP) {
				g.moveTo(0, -10);
				g.lineTo(-10, 10);
				g.lineTo(10, 10);
			}
			g.endFill();
		}
	}
}
