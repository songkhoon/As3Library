package views {
	import controllers.IController;

	public interface IViewer {
		function destroy():void;
		function get controller():IController;
		function set controller($controller:IController):void;
	}
}
