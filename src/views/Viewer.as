package views {
	import controllers.IController;

	public class Viewer extends Scene implements IViewer {
		private var _controller:IController;
		public function Viewer($controller:IController = null) {
			super();
			controller = $controller;
		}

		public function destroy():void {
		}
		
		public function get controller():IController{
			return _controller;
		}
		
		public function set controller($controller:IController):void{
			_controller = $controller;
		}

	}
}
