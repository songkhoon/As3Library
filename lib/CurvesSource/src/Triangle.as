package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Shiu
	 */
	public class Triangle extends Sprite
	{
		private var _w:Number = 20;
		private var _h:Number = 20;
		
		public function Triangle() 
		{
			draw();
		}
		
		public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(0xFF9933);
			graphics.lineStyle(1);
			graphics.drawPath(new <int> [1, 2, 2, 2], new <Number>[0.66*_w, 0, -0.33 * _w, 0.5 * _h, -0.33 * _w, -0.5 * _h, 0.66*_w, 0,]);
			graphics.endFill();
		}
		
		public function get h():Number 
		{
			return _h;
		}
		
		public function set h(value:Number):void 
		{
			_h = value;
			draw();
		}
		
		public function get w():Number 
		{
			return _w;
		}
		
		public function set w(value:Number):void 
		{
			_w = value;
			draw();
		}
		
	}

}