package de.eiszfuchs.game.arrowmania {

	import flash.events.Event;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ShaderFilter;

	/**
	 * @author eiszfuchs
	 */
	public class Noisy extends Sprite {

		[Embed(source="/de/eiszfuchs/shader/noise.pbj", mimeType="application/octet-stream")] public var NOISESHADER:Class;
		public function Noisy():void {
			super();
		}

		private var startX:Number = 0;
		private var startY:Number = 0;

		protected var blurFilter:BlurFilter;
		protected var shaderFilter:ShaderFilter;
		protected var shaderFilterShader:Shader;

		protected function startNoise():void {
			this.startX = this.x;
			this.startY = this.y;

			this.shaderFilterShader = new Shader(new NOISESHADER());

			this.blurFilter = new BlurFilter(0, 0, 2);
			this.shaderFilter = new ShaderFilter(this.shaderFilterShader);

			this.addEventListener(Event.ENTER_FRAME, this.noise);
		}

		protected function stopNoise():void {
			this.removeEventListener(Event.ENTER_FRAME, this.noise);
			this.filters = [];
		}

		protected var displacedY:int = 0;

		protected function noise(event:Event = null):void {
			// random offset

			if (Math.random() > 0.9) {
				this.x = this.startX + Math.random() * 10 - 5;
			} else {
				this.x = this.startX;
			}

			if (this.displacedY <= 0) {
				if (Math.random() > 0.95) {
					this.y = this.startY + Math.random() * 20 - 10;
					this.displacedY = Math.floor(Math.random() * 20);

					this.blurFilter.blurX = 0;

					this.shaderFilter.shader.data.redShiftX.value = [Math.floor(Math.random() * 10 - 5)];
					this.shaderFilter.shader.data.greenShiftX.value = [Math.floor(Math.random() * 10 - 5)];
					this.shaderFilter.shader.data.blueShiftX.value = [Math.floor(Math.random() * 10 - 5)];
				} else {
					this.y = this.startY;

					this.blurFilter.blurX = Math.random() * 10;

					this.shaderFilter.shader.data.redShiftX.value =
						this.shaderFilter.shader.data.greenShiftX.value =
						this.shaderFilter.shader.data.blueShiftX.value = [0];
				}
			} else {
				this.displacedY -= 1;
			}

			this.filters = [
				this.blurFilter,
				this.shaderFilter
			];
		}
	}
}
