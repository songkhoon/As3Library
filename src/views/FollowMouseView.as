package views {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import controllers.IController;

	public class FollowMouseView extends Viewer {
		private var _ball:Ball;
		private var _timer:Timer;
		private var _mode:String;
		private var _speed:Number = 10;
		
		public function FollowMouseView($controller:IController = null) {
			super($controller);
			_ball = new Ball();
			this.addChild(_ball);
			
			_mode = "easefollow";
			_timer = new Timer(20);
			_timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			_timer.start();
		}

		protected function onTimerHandler(event:TimerEvent):void {
			var $dist:Number = Math.sqrt((this.mouseX-_ball.x)*(this.mouseX-_ball.x) + (this.mouseY-_ball.y)*(this.mouseY-_ball.y));
			if(_mode == "normal"){
				_ball.x = this.mouseX;
				_ball.y = this.mouseY;
			}else if(_mode == "follow"){
				if($dist<_speed){
					_ball.x = this.mouseX;
					_ball.y = this.mouseY;
				}else{
					var r:Number = Math.atan2(this.mouseY - _ball.y, this.mouseX - _ball.x);
					_ball.x += Math.cos(r)*_speed;
					_ball.y += Math.sin(r)*_speed;
				}
				
			}else if(_mode == "easefollow"){
				_ball.x += (this.mouseX - _ball.x)/_speed;
				_ball.y += (this.mouseY - _ball.y)/_speed;
			}
		}
	}
}
