package {
	import flash.events.Event;
	
	import views.CurveView;
	import views.FollowMouseView;
	import views.MovingObjectView;
	import views.SmoothDrawView;

	[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFFFFF")]
	public class Main extends Application {
		public function Main():void {
			super();
		}

		override protected function init(e:Event):void {
			super.init(e);
			
			var $smoothDrawView:SmoothDrawView = new SmoothDrawView(stage.stageWidth, stage.stageHeight);
			//this.addChild($smoothDrawView);
			
			//var $curveView:CurveView = new CurveView();
			//this.addChild($curveView);
			
			var $movingObjectView:MovingObjectView = new MovingObjectView();
			//this.addChild($movingObjectView);
			
			var $followMouseView:FollowMouseView = new FollowMouseView();
			this.addChild($followMouseView);
		}

		

	}

}
