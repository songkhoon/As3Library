package views {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import controllers.IController;

	public class MovingObjectView extends Viewer {
		private var _ballVec:Vector.<Ball>;
		public function MovingObjectView($controller:IController = null) {
			super($controller);
			_ballVec = new Vector.<Ball>();
			_ballVec.push(new Ball());
			for(var i:uint = 0;i<_ballVec.length;i++){
				this.addChild(_ballVec[i]);
			}
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function moveLinear(d:Sprite, $stPoint:Point, $endPoint:Point):void{
			d.x = $stPoint.x;
			d.y = $stPoint.y;
			d.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void{
			var a:Number = 45;
			for(var i:uint=0;i<_ballVec.length;i++){
				_ballVec[i].x += Math.cos(a*Math.PI/180);
				_ballVec[i].y += Math.sin(a*Math.PI/180);
			}
		}
	}
}
