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
	public class Region_Curve2 extends Sprite
	{
		private var c1:Circle, c2:Circle, c3:Circle, c4:Circle;
		private var background:Vector.<Circle>;
		
		public function Region_Curve2() 
		{
			//setting up background
			background = new Vector.<Circle>;
			for (var j:int = 0; j < 40; j++) {
				for (var i:int = 0; i < 40; i++) {
					var b:Circle = new Circle(0xAAAAAA, 4); addChild(b);
					b.x = i * 10; b.y = j * 10;
					background.push(b);
				}
			}
			
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
		
		private function redraw():void {
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
			for each (var item: Circle in background) {
				var D:Number = right.n11 * item.x * item.x * item.x+ 
											right.n21 *item.x * item.x+ 
											right.n31 * item.x +
											right.n41;
				if (item.y > D) item.color = 0;
				else item.color = 0xAAAAAA;
			}
		}
		
	}

}