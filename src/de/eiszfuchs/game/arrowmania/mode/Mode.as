package de.eiszfuchs.game.arrowmania.mode {

	import de.eiszfuchs.game.arrowmania.Game;
	import de.eiszfuchs.game.arrowmania.Arrow;

	import de.eiszfuchs.utils.Settings;

	import flash.net.*;

	/**
	 * @author eiszfuchs
	 */
	public class Mode {

		public var tickLength:int;
		public var tickDecrease:int;

		public var speed:Number;
		public var speedStep:Number;
		public var speedIncrease:int;

		public var skipArrows:int;
		public var highscore:int = 0;

		protected var identifier:String;

		public function Mode():void {
			this.tickLength = 60;
			this.tickDecrease = 10;

			this.speed = 1;
			this.speedStep = 0.05;
			this.speedIncrease = 15;

			this.skipArrows = 0;
		}

		public function emit(index:int = 0):Arrow {
			var dir:int = this.randomDirection();

			return new Arrow(dir, dir, dir, this.randomColor(), true);
		}

		public function check(arrows:Array, pressed:int):Object {
			var arrow:Arrow = arrows[0];
			var key:int = arrow.getDirection();

			return this.checkResponse(key, key === pressed, 0, 1);
		}

		private function checkResponse(key:int, correct:Boolean = false, killIndex:int = 0, killAmount:int = 0):Object {
			return {
				key: key,
				correct: correct,
				killIndex: killIndex,
				killAmount: killAmount
			};
		}

		public function getScore():int {
			return Settings.getSetting(this.identifier, 0);
		}

		public function postScore():void {
			var url:String = "scoreboard.php";
			var request:URLRequest = new URLRequest(url);
			var requestVars:URLVariables = new URLVariables();
				requestVars.score = this.getScore();
				requestVars.mode = this.identifier;
				requestVars.player_id = Settings.getSetting('player_id', -1);
				requestVars.player_nick = Settings.getSetting('player_nick', "Player");
				requestVars.date = (new Date).getTime();
			request.data = requestVars;
			request.method = URLRequestMethod.POST;

			var urlLoader:URLLoader = new URLLoader();
			urlLoader = new URLLoader();
				// urlLoader.addEventListener(Event.COMPLETE, loaderCompleteHandler, false, 0, true);
				// urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
				// urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
				// urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);

			try {
				urlLoader.load(request);
			} catch (ex:Error) {
				// nop
			}

		}

		public function updateScore(score:int = 0):void {
			this.highscore = Settings.getSetting(this.identifier, 0);
			this.highscore = Math.max(score, this.highscore);
			Settings.setSetting(this.identifier, this.highscore);
		}

		protected function randomIndex():int {
			return Math.floor(Math.random() * 4);
		}

		protected function getDirection(index:int):int {
			var directions:Array = [Game.UP, Game.DOWN, Game.LEFT, Game.RIGHT];
			return directions[index];
		}

		protected function getColor(index:int):uint {
			var colors:Array = [Game.RED, Game.BLUE, Game.GREEN, Game.YELLOW];
			return colors[index];
		}

		protected function reverseDirection(direction:int):int {
			switch (direction) {
				case Game.UP:
					return Game.DOWN;
				case Game.RIGHT:
					return Game.LEFT;
				case Game.DOWN:
					return Game.UP;
				case Game.LEFT:
					return Game.RIGHT;
			}

			return -1;
		}

		protected function rotateDirection(direction:int, counter:Boolean = false):int {
			switch (direction) {
				case Game.UP:
					if (counter) return Game.LEFT;
					return Game.RIGHT;
				case Game.RIGHT:
					if (counter) return Game.UP;
					return Game.DOWN;
				case Game.DOWN:
					if (counter) return Game.RIGHT;
					return Game.LEFT;
				case Game.LEFT:
					if (counter) return Game.DOWN;
					return Game.UP;
			}

			return -1;
		}

		protected function randomDirection():int {
			return this.getDirection(this.randomIndex());
		}

		protected function randomColor():int {
			return this.getColor(this.randomIndex());
		}
	}
}
