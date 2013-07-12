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
	public class Draw_Curve2 extends Sprite
	{
		private var c1:Circle, c2:Circle, c3:Circle, c4:Circle;
		
		public function Draw_Curve2() 
		{
			//setting up controls
			c1 = new Circle(0xFF0000); addChild(c1); c1.x = stage.stageWidth * 0.2; c1.y = stage.stageHeight >> 1;
			c2 = new Circle(0xFF0000); addChild(c2); c2.x = stage.stageWidth * 0.4; c2.y = stage.stageHeight >> 1;
			c3 = new Circle(0xFF0000); addChild(c3); c3.x = stage.stageWidth * 0.6; c3.y = stage.stageHeight >> 1;
			c4 = new Circle(0xFF0000); addChild(c4); c4.x = stage.stageWidth * 0.8; c4.y = stage.stageHeight >> 1;
			
			c1.addEventListener(MouseEvent.MOUSE_DOWN, move);
			c1.addEventListener(MouseEvent.MOUSE_UP, move);
			c2.addEventListener(MouseEvent.MOUSE_DOWN, move);
			c2.addEventListener(MouseEvent.MOUSE_UP, move);
			c3.addEventListener(MouseEvent.MOUSE_DOWN, move);
			c3.addEventListener(MouseEvent.MOUSE_UP, move);
			c4.addEventListener(MouseEvent.MOUSE_DOWN, move);
			c4.addEventListener(MouseEvent.MOUSE_UP, move);
			
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
			var left:Matrix3d = new Matrix3d(c1.x * c1.x* c1.x, 	c1.x* c1.x, 	c1.x , 	1,
																c2.x * c2.x * c2.x, 	c2.x* c2.x, 	c2.x , 	1,
																c3.x * c3.x * c3.x, 	c3.x* c3.x, 	c3.x , 	1,
																c4.x * c4.x * c4.x, 	c4.x* c4.x, 	c4.x , 	1);
			left.invert()
			var right:Matrix3d = new Matrix3d(c1.y, 	0, 	0, 	0,
																	c2.y, 	0, 	0, 	0,
																	c3.y, 	0, 	0, 	0,
																	c4.y, 	0, 	0, 	0);
			right.append(left);
			
			//f(x) = A(x^3) + B (x^2) +C (x) + D
			graphics.clear();
			var points:Vector.<Number> = new Vector.<Number>;
			var cmd:Vector.<int> = new Vector.<int>;
			for (var i:int = 0; i < 200; i++) {
				var x:Number = i * 2;
				var y:Number = right.n11 * x * x * x+ 
											right.n21 * x * x+ 
											right.n31 * x +
											right.n41;
				
				points.push(x, y);
				if (i == 0) cmd.push(1);
				else cmd.push(2);
			}
			graphics.lineStyle(1);
			graphics.drawPath(cmd, points);
		}
		
	}

}