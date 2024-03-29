package de.eiszfuchs.game.arrowmania {

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.*;
	import flash.ui.Keyboard;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import de.eiszfuchs.game.arrowmania.mode.*;

	/**
	 * @author eiszfuchs
	 */
	public class Game extends Noisy {

		private var points:int;
		private var emitCount:int;

		private var arrows:Array;

		private var tick:int;
		private var tickStep:int;
		private var tickLengthMin:int;
		private var tickLengthBase:int;
		private var tickLength:int;
		private var tickDecrease:int;

		private var speed:Number;
		private var speedBase:Number;
		private var speedStep:Number;
		private var speedIncrease:int;

		private var mode:Mode;

		public function Game(mode:Mode):void {
			this.mode = mode;

			this.init();
		}

		public static const UP:int = 1;
		public static const RIGHT:int = 3;
		public static const DOWN:int = 2;
		public static const LEFT:int = 0;

		public static const BLACK:uint = 0x000000;
		public static const WHITE:uint = 0xffffff;
		public static const SLOT:uint = 0xb2b2b2;
		public static const RED:uint = 0xD10D51;
		public static const GREEN:uint = 0x4FB81F;
		public static const BLUE:uint = 0x1350D4;
		public static const YELLOW:uint = 0xD4CC31;

		private function init():void {
			build();

			this.tick = 1;
			this.tickLengthBase = this.mode.tickLength;
			this.tickLengthMin = 2;
			this.tickLength = this.tickLengthBase;
			this.tickStep = this.mode.tickStep;
			this.tickDecrease = this.mode.tickDecrease;

			this.speedBase = this.mode.speed;
			this.speed = this.speedBase;
			this.speedStep = this.mode.speedStep;
			this.speedIncrease = this.mode.speedIncrease;

			this.points = 0;
			this.arrows = new Array;
			this.emitCount = this.mode.skipArrows;

			this.addEventListener(Event.ENTER_FRAME, this.update);
			this.addEventListener(Event.ENTER_FRAME, this.updateTick);
			Main.master.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.react);
		}

		private var scoreFormat:TextFormat;
		private var scoreField:TextField;
		private function build():void {
			scoreFormat = new TextFormat;
			scoreFormat.font = "News Cycle Bold";
			scoreFormat.size = 16;
			scoreField = new TextField;
			scoreField.type = TextFieldType.DYNAMIC;
			scoreField.textColor = RED;
			scoreField.embedFonts = true;
			scoreField.mouseEnabled = false;
			scoreField.selectable = false;
			scoreField.autoSize = TextFieldAutoSize.LEFT;
			scoreField.defaultTextFormat = this.scoreFormat;
			scoreField.text = "";

			addChild(scoreField);

			// slot arrows
			for (var i:int = 0; i < 4; i += 1) {
				var slotShape:Shape = new Shape;

				var g:Graphics = slotShape.graphics;
				g.clear();
				g.beginFill(SLOT);
				Arrow.shape(g);
				g.endFill();

				slotShape.x = (i + 1) * 30;
				slotShape.y = Main.master.stage.stageHeight - 30;
				Arrow.rotate(slotShape, i);
				this.addChild(slotShape);
			}

			// bounds
			g = this.graphics;
			g.clear();
			g.lineStyle();

			// basically, the problem here was that the clip
			// was way too high for the filters to be
			// rendered - so we only draw the bounds if they
			// are needed

			if (this.mode.catchBelow >= 0) {
				g.beginFill(SLOT);
				g.drawRect(10, this.mode.catchBelow, 130, 1);
				g.moveTo(15, this.mode.catchBelow - 1);
				g.lineTo(20, this.mode.catchBelow - 7);
				g.lineTo(10, this.mode.catchBelow - 7);
				g.endFill();
			}

			if (this.mode.catchAbove < 420) {
				g.beginFill(SLOT);
				g.drawRect(10, this.mode.catchAbove, 130, 1);
				g.moveTo(15, this.mode.catchAbove + 1);
				g.lineTo(20, this.mode.catchAbove + 7);
				g.lineTo(10, this.mode.catchAbove + 7);
				g.endFill();
			}
		}

		private function updateTick(event:Event = null):void {
			tick += 1;
			if (tick > this.tickLength) {
				tick = 1;
			}
		}

		private function update(event:Event = null):void {
			if (tick === 1) {
				this.emit();
			}

			for (var i:int = 0; i < this.arrows.length; i += 1) {
				this.arrows[i].y -= this.speed;
				this.arrows[i].update(this.tick, this.tickLength);
			}

			if (this.arrows.length > 0) {
				var check:Object = this.mode.check(this.arrows);
				if (!check.correct) {
					this.death = check.key;
					this.die();

					return;
				}
			}

			this.tickLength = this.tickLengthBase - this.tickStep * Math.floor(this.emitCount / this.tickDecrease);
			this.tickLength = Math.max(this.tickLength, this.tickLengthMin);
			this.speed = this.speedBase + this.speedStep * Math.floor(Math.pow(this.emitCount, this.mode.speedIncreasePower) / this.speedIncrease);

			// clean up numbers
			this.tickLength = Math.round(this.tickLength * 100) / 100;
			this.speed = Math.round(this.speed * 100) / 100;

			scoreField.text = "";
		}

		private var died:Boolean = false;
		private var death:int;

		private function react(event:KeyboardEvent = null):void {
			var key:uint = event.keyCode;

			if (this.died) {
				switch (key) {
					case Keyboard.ENTER:
						this.restart();
						return;
					case Keyboard.ESCAPE:
						this.parent.addChild(new Menu);
						this.kill();
						return;
				}
			} else {
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

				if (this.arrows.length < 1) {
					return;
				}

				var check:Object = this.mode.check(this.arrows, key);
				if (check.correct) {
					this.points += check.killAmount;

					for (var i:int = 0; i < check.killAmount; i += 1) {
						var arrow:Arrow = this.arrows.splice(check.killIndex, 1)[0];
						arrow.kill(this.points.toString(10));
					}

					if (this.arrows.length < 1) {
						// livin' on the edge!
						// this.tick = 1;
					}
				} else {
					this.death = check.key;
					this.die();
				}
			}
		}

		/**
		 * position  - slot
		 * direction - arrow direction
		 * target    - which button needs to be pressed
		 * color     - color
		 * flashing  - flashes?
		 */
		private function emit():void {
			var arrow:Arrow = this.mode.emit(this.emitCount);

			if (arrow === null) return;

			arrow.y = this.stage.stageHeight - 30;
			this.addChild(arrow);

			this.arrows.push(arrow);

			this.emitCount += 1;
		}

		private function die():void {
			this.removeEventListener(Event.ENTER_FRAME, this.update);

			this.mode.updateScore(this.points);

			this.mode.postScore();

			scoreFormat.size = 56;
			scoreField.text = this.points.toString(10) + "\n(high: " + this.mode.highscore.toString(10) + ")\n[ENTER]\n[ESC]";
			scoreField.setTextFormat(scoreFormat, 0, this.points.toString(10).length);
			scoreField.x = 10;
			scoreField.y = -10;

			// this.rotation = 5;

			// what had to be pressed?
			var correct:Shape = new Shape;

			var g:Graphics = correct.graphics;
			g.clear();
			g.lineStyle(1, WHITE, 0.5, true);
			g.beginFill(BLACK, 0.5);
			Arrow.shape(g);
			g.endFill();

			correct.x = 150 / 2;
			correct.y = Main.master.stage.stageHeight / 2;
			correct.scaleX = correct.scaleY = 6;
			Arrow.rotate(correct, death);
			this.addChild(correct);

			// end of game

			this.died = true;

			this.startNoise();
		}

		private function restart():void {
			this.parent.addChild(new Game(this.mode));
			this.kill();
		}

		private function kill():void {
			Main.master.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.react);
			this.removeEventListener(Event.ENTER_FRAME, this.updateTick);
			this.stopNoise();

			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}
