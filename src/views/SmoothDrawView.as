package views {
	import flash.geom.Rectangle;
	
	import smooth.Canvas;

	public class SmoothDrawView extends Viewer {

		public function SmoothDrawView(w:Number, h:Number) {
			super();
			var canvas:Canvas = new Canvas();
			addChild(canvas.container);
			canvas.rect = new Rectangle(0, 0, w, h);
			
			graphics.lineStyle(0, 0, .5);
			graphics.drawRect(0, 0, w - 1, h - 1);

		}


	}
}
