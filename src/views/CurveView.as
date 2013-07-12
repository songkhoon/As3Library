package views {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import controllers.IController;
	
	import models.Bezier;

	public class CurveView extends Viewer {
		private var _curveData:Vector.<Array> = Vector.<Array>([[66, 134], [50, 225], [53, 335], [76, 458], [135, 500], [300, 459]]);
		private var _stepLength:uint = 2;
		private var _mapData:Array;
		private var _circleSp:Sprite;
		private var _timer:Timer;
		private var _circleVec:Vector.<Ball>;

		public function CurveView($controller:IController = null) {
			super($controller);
			graphics.lineStyle(2, 0xFF0000);
			for (var i:uint = 0; i < _curveData.length; i++) {
				graphics.beginFill(0xFF0000, 1);
				graphics.drawCircle(_curveData[i][0], _curveData[i][1], 5);
				graphics.endFill();
			}

			initMap(_curveData);
			
			initEvent();
		}

		private function initMap(arr:Vector.<Array>):void {
			_mapData = new Array();
			graphics.lineStyle(2, 0x000000);
			graphics.moveTo(arr[0][0], arr[0][1]);
			for (var i:uint = 1; i < arr.length - 2; ++i) {
				var xc:Number = (arr[i][0] + arr[i + 1][0]) / 2;
				var yc:Number = (arr[i][1] + arr[i + 1][1]) / 2;
				graphics.curveTo(arr[i][0], arr[i][1], xc, yc);
			}
			/*
			new Point((arr[j][0] + arr[j+1][0])/2,(arr[j][1] + arr[j+1][1])/2)
			new Point(arr[j+1][0],arr[j+1][1])
			new Point((arr[j+1][0] + arr[j+2][0])/2,(arr[j+1][1] + arr[j+2][1])/2)
			*/
			graphics.curveTo(arr[i][0], arr[i][1], arr[i + 1][0], arr[i + 1][1]);
			for (var j:uint = 0; j < arr.length - 2; ++j) {
				var p0:Point = (j == 0) ? new Point(arr[0][0], arr[0][1]) : new Point((arr[j][0] + arr[j + 1][0]) / 2, (arr[j][1] + arr[j + 1][1]) / 2);
				var p1:Point = new Point(arr[j + 1][0], arr[j + 1][1]);
				var p2:Point = (j <= arr.length - 4) ? new Point((arr[j + 1][0] + arr[j + 2][0]) / 2, (arr[j + 1][1] + arr[j + 2][1]) / 2) : new Point(arr[j + 2][0], arr[j + 2][1]);
				var steps:uint = Bezier.init(p0, p1, p2, _stepLength);
				for (var m:uint = 1; m <= steps; ++m) {
					var data:Array = Bezier.getAnchorPoint(m);
					_mapData.push(data);
				}
			}

			for (i = 0; i < _mapData.length; i = i + 18) {
				graphics.beginFill(0xFF3300, 1);
				graphics.drawCircle(_mapData[i][0], _mapData[i][1], 18);
				graphics.endFill();
			}
			
			_circleVec = new Vector.<Ball>();
			

			for (i = 0; i < 3; i++) {
				var $ball:Ball = new Ball(i*18);
				$ball.x = _mapData[i*18][0];
				$ball.y = _mapData[i*18][1];
				_circleVec.push($ball);
				this.addChild(_circleVec[i]);
			}


			_timer = new Timer(50, 0);
			_timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			_timer.start();

		}
		
		private function initEvent():void{
			this.addEventListener(MouseEvent.CLICK, onMouseClickHandler);
		}
		
		private function onMouseClickHandler(e:MouseEvent):void{
			var $stPoint:Point = new Point(Application.STAGE_WIDTH >> 1, Application.STAGE_HEIGHT);
			var $ball:Ball = new Ball();
			$ball.x = $stPoint.x;
			$ball.y = $stPoint.y;
			
			
		}

		protected function onTimerHandler(e:TimerEvent):void {
			for(var i:uint=0;i<_circleVec.length;i++){
				_circleVec[i].pos = Math.min(++_circleVec[i].pos, _mapData.length - 1);
				_circleVec[i].x = _mapData[_circleVec[i].pos][0];
				_circleVec[i].y = _mapData[_circleVec[i].pos][1];
			}
				
		}

		private function getCircle($p:uint):Sprite {
			var $sp:Sprite = new Sprite();
			$sp.graphics.beginFill(0x000000);
			$sp.graphics.drawCircle(_mapData[$p][0], _mapData[$p][1], 18);
			$sp.graphics.endFill();
			return $sp;
		}

	}
}
