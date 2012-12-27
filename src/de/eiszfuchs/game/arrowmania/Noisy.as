package de.eiszfuchs.game.arrowmania {

	import flash.events.Event;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;

	/**
	 * @author eiszfuchs
	 */
	public class Noisy extends Sprite {

		public function Noisy():void {
			super();
		}

		protected function startNoise():void {
			this.addEventListener(Event.ENTER_FRAME, this.noise);
		}

		protected function stopNoise():void {
			this.removeEventListener(Event.ENTER_FRAME, this.noise);
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
	}
}
