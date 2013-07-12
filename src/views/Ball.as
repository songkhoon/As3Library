package views {
	import flash.display.Sprite;

	public class Ball extends Sprite {
		private var _pos:uint;
		
		public function Ball($pos:uint = 0) {
			super();
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, 18);
			graphics.endFill();
			pos = $pos;
		}

		public function get pos():uint {
			return _pos;
		}

		public function set pos(value:uint):void {
			_pos = value;
		}

	}
}
