package  
{
	import flash.display.Sprite;
	/**
	 * Circle
	 * Purpose: Circle object
	 * @author Shiu
	 */
	public class Circle extends Sprite
	{
		private var _col:Number, _radius:Number;
		private var _drawBound:Boolean = false;
		
		public function Circle(color:Number, radius:Number = 10) {
			_col = color, _radius = radius;
			draw();
		}
		
		private function draw():void {
			graphics.lineStyle(1); 
			graphics.beginFill(_col);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
		}
		
		public function set color (value:Number):void {
			_col = value;
			graphics.clear()
			draw();
		}
		
		public function get radius ():Number {
			return _radius;
		}
		
		public function set showBound(status:Boolean):void {
			_drawBound = status;
			graphics.clear();
			draw()
			if(_drawBound){
				graphics.lineStyle(1);
				graphics.drawRect(_radius * -1, _radius * -1, _radius*2, _radius*2);
				
			}
		}
		
		public function get showBound ():Boolean {
			return _drawBound;
		}
		
		
	}

}