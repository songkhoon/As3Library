package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Shiu
	 */
	public class Triangle2 extends Sprite
	{
		private var _w:Number = 50;
		private var _h:Number = 25;
		
		public function Triangle2() 
		{
			graphics.beginFill(0xFF9933);
			graphics.lineStyle(3);
			graphics.moveTo(0, _h * 0.5);
			graphics.lineTo(_w * 0.5, 0);
			graphics.lineTo(_w * 0.5, _h * 0.5);
			graphics.lineTo(_w, 0);
			graphics.lineTo(_w * 0.5, _h * -0.5);
			graphics.lineTo(_w * 0.5, 0);
			graphics.lineTo(0, _h * -0.5);
			graphics.lineTo(0, _h * 0.5);
			graphics.endFill();
		}
		
	}

}