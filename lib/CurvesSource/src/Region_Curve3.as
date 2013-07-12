package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import net.richardlord.coral.Matrix3d;
	/**
	 * ...
	 * @author Shiu
	 */
	[SWF(width = 400, height = 400)]
	public class Region_Curve3 extends Sprite
	{
		private var c1:Circle, c2:Circle, c3:Circle;
		private var background:Vector.<Circle>;
		
		public function Region_Curve3() 
		{
			//setting up background
			background = new Vector.<Circle>;
			for (var j:int = 0; j < 20; j++) {
				for (var i:int = 0; i < 20; i++) {
					var b:Circle = new Circle(0xAAAAAA, 8); addChild(b);
					b.x = i * 20; b.y = j * 20;
					background.push(b);
				}
			}
			
			//setting up controls
			c1 = new Circle(0xFF0000); addChild(c1); c1.x = stage.stageWidth * 0.2; c1.y = stage.stageHeight >> 1;
			c2 = new Circle(0xFF0000); addChild(c2); c2.x = stage.stageWidth * 0.5; c2.y = stage.stageHeight >> 1;
			c3 = new Circle(0xFF0000); addChild(c3); c3.x = stage.stageWidth * 0.8; c3.y = stage.stageHeight >> 1;
			
			c1.addEventListener(MouseEvent.MOUSE_DOWN, move);
			c1.addEventListener(MouseEvent.MOUSE_UP, move);
			c2.addEventListener(MouseEvent.MOUSE_DOWN, move);
			c2.addEventListener(MouseEvent.MOUSE_UP, move);
			c3.addEventListener(MouseEvent.MOUSE_DOWN, move);
			c3.addEventListener(MouseEvent.MOUSE_UP, move);
			redraw();
		}
		
		private function move(e:MouseEvent):void {
			if (e.type == "mouseDown") {
				e.target.startDrag()
				e.target.addEventListener(MouseEvent.MOUSE_MOVE, update);
			}
			else if (e.type == "mouseUp") {
				e.target.stopDrag();
				e.target.removeEventListener(MouseEvent.MOUSE_MOVE, update);
			}
		}
		
		private function update(e:MouseEvent):void {
			redraw();
		}
		
		private function redraw():void 
		{
			var left:Matrix3d = new Matrix3d(c1.x * c1.x, c1.x, 1,	0,
																c2.x * c2.x, 	c2.x, 1,	 	0,
																c3.x * c3.x, 	c3.x, 1,	 	0,
																0, 				0, 	0, 	1);
			left.invert()
			var right:Matrix3d = new Matrix3d(c1.y, 	0, 	0, 	0,
																	c2.y, 	0, 	0, 	0,
																	c3.y, 	0, 	0, 	0,
																	0, 	0, 	0, 	0);
			right.append(left);
			
			//getting the maximum &
			//storing the offset from curve
			var max:Number = 0;
			var min:Number = 0;
			var Ds:Vector.<Number> = new Vector.<Number>;
			
			//D = A(x^2) + B (x) +C 
			for each (var item: Circle in background) {
				var D:Number = right.n11 * item.x * item.x + right.n21 * item.x + right.n31;
				var offset:Number = item.y - D;
				Ds.push(offset);
				
				if (item.y > D && offset > max) max = offset;
				else if (item.y < D && offset < min) min = offset;
			}
				
			//color variations based on the offset
			var color:Number
			for (var i:int = 0; i < background.length; i++) {
				if (Ds[i] > 0) {
					color = Ds[i] / max * 255							//calculating color to slot in
					background[i].color = color<<16 | color<<8 | color;	//define a grayscale
				}
				else if (Ds[i] < 0)	{
					color = Ds[i] / min * 255;
					background[i].color = color<<16;	//define a gradient of red
				}
			}
		}
		
	}

}