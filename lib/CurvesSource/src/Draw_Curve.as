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
	public class Draw_Curve extends Sprite
	{
		private var c1:Circle, c2:Circle, c3:Circle;
		private var K:Matrix3d, L:Matrix3d;
		
		public function Draw_Curve() 
		{
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
			redraw()
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
			K = new Matrix3d(	c1.x * c1.x, 	c1.x, 	1, 	0,
												c2.x * c2.x, 	c2.x, 	1, 	0,
												c3.x * c3.x, 	c3.x, 	1, 	0,
												0, 				0, 		0, 	1);
			K.invert()
			L = new Matrix3d(	c1.y, 	0, 	0, 	0,
												c2.y, 	0, 	0, 	0,
												c3.y, 	0, 	0, 	0,
												0, 	0, 	0, 	0);
			L.append(K);
			
			graphics.clear();
			var points:Vector.<Number> = new Vector.<Number>;
			var cmd:Vector.<int> = new Vector.<int>;
			for (var i:int = 0; i < 200; i++) {
				//current x
				var x:Number = i * 2;
				
				//f(x) = A (x^2) + B (x) + C 
				var y:Number = L.n11* x* x + L.n21 * x + L.n31 ;
				
				points.push(x, y);
				if (i == 0) cmd.push(1);
				else cmd.push(2);
			}
			graphics.lineStyle(1);
			graphics.drawPath(cmd, points);
		}
		
	}

}