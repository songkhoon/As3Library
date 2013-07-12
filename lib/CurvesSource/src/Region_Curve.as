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
	public class Region_Curve extends Sprite
	{
		private var c1:Circle, c2:Circle, c3:Circle;
		private var background:Vector.<Circle>;
		
		public function Region_Curve() 
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
		
		private function redraw():void {
			var left:Matrix3d = new Matrix3d(c1.x * c1.x, 	c1.x, 	1, 	0,
																c2.x * c2.x, 	c2.x, 	1, 	0,
																c3.x * c3.x, 	c3.x, 	1, 	0,
																0, 				0, 		0, 	1);
			left.invert()
			var right:Matrix3d = new Matrix3d(c1.y, 	0, 	0, 	0,
																	c2.y, 	0, 	0, 	0,
																	c3.y, 	0, 	0, 	0,
																	0, 	0, 	0, 	0);
			right.append(left);
			
			//D = A (x^2)+ B (x) +C 
			for each (var item: Circle in background) {
				var D:Number = right.n11* item.x * item.x + right.n21 * item.x + right.n31 ;
				//trace(background[i].y);
				if (item.y > D) item.color = 0;
				else item.color = 0xAAAAAA;
				
			}
		}
		
	}

}