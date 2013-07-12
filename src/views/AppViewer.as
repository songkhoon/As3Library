package views {
	import flash.display.Sprite;

	public class AppViewer implements IAppViewer{
		public function AppViewer() {
			super();
		}
		
		public function destroy():void{
			
		}
		public function addSprite():Sprite{
			var $sp:Sprite = new Sprite();
			return $sp;
		}
		

	}
}
