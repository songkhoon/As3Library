package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Capabilities;
	import flash.events.Event;

	public class Application extends Sprite {
		public static var STAGE_WIDTH:Number;
		public static var STAGE_HEIGHT:Number;
		public static var IS_BROWSER : Boolean;
		public static var IS_ONLINE : Boolean;
		public static var IS_DEBUG : Boolean;
		
		private static var _instance:Application;
		
		public function Application() {
			super();

			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public static function get instance():Application {
			return _instance;
		}

		public static function set instance(value:Application):void {
			_instance = value;
		}

		protected function init(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			IS_ONLINE = (stage.loaderInfo.url.indexOf("http") == 0);
			IS_BROWSER = (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn");
			IS_DEBUG = (Capabilities.playerType == "StandAlone" || Capabilities.playerType == "External" || stage.loaderInfo.url.indexOf("http") != 0);
			
			_instance = this;
			if(!STAGE_WIDTH)
				STAGE_WIDTH = this.stage.stageWidth;
			if(!STAGE_HEIGHT)
				STAGE_HEIGHT = this.stage.stageHeight;
			
			setupStage();
		}
		
		protected function setupStage() : void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}

	}
}
