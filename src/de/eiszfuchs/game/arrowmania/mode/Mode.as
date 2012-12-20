package de.eiszfuchs.game.arrowmania.mode {
	
	/**
	 * @author eiszfuchs
	 */
	public class Mode {
		
		public var tickLength:int;
		public var tickDecrease:int;

		public var speed:Number;
		public var speedStep:Number;
		public var speedIncrease:int;

		public var mockStart:int;
		public var mockPosition:Boolean;
		public var mockDirection:Boolean;

		public function Mode():void {
			tickLength = 60;
			tickDecrease = 10;
			speed = 1;
			speedStep = 0.1;
			speedIncrease = 30;
			mockStart = 100;
			mockPosition = false;
			mockDirection = false;
		}
	}
}
