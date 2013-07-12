package views {
	
	import controllers.IController;
	
	public class CurveLineView extends Viewer {
		
		public function CurveLineView($controller:IController = null) {
			super($controller);
			var a:Number, b:Number, c:Number;
			
		}
		
		private function quadratic1(x:Number, A:Number, B:Number, C:Number):Number {
			//y = A(x^2) + B(x) + C
			return A*x*x+ B*x + C;
		}
	}
}
