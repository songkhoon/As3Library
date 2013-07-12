package controllers {
	import flash.display.Stage;
	
	import views.SmoothDrawView;

	public class AppController {
		private var _stage:Stage;
		public function AppController($stage:Stage) {
			_stage = $stage;
			addDrawLine();
		}
		
		private function addDrawLine():void{
			var $smoothDrawView:SmoothDrawView = new SmoothDrawView(_stage.stageWidth, _stage.stageHeight);
			//_stage.addChild($smoothDrawView);
			
		}
		
		
		
	}
}
