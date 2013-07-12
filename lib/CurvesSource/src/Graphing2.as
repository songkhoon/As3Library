package  
{
	import fl.controls.Button;
	import flash.display.Sprite;
	import fl.controls.NumericStepper;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Shiu
	 */
	[SWF(width = 600, height = 400)]
	public class Graphing2 extends Sprite{
		private var text_A:NumericStepper, text_B:NumericStepper, text_C:NumericStepper, text_D:NumericStepper;
		private var t:TextField;
		
		private var points:Vector.<Number> = new Vector.<Number>;
		private	var drawCommand:Vector.<int> = new Vector.<int>;
		private var graph:Sprite;
		
		private function setup():void {
			t = new TextField(); addChild(t);
			t.selectable = false; t.width = 250; t.height = 300;
			t.text = "f(x)\t =\t A (x^3)\t +\t B (x^2)\t +\t C (x) +\t D\n\nA\t=\n\nB\t=\n\nC\t=\n\nD\t=\n\n";
			
			var offsetx:Number = 40; var offsety:Number = 30;
			var space:Number = 10;
			text_A = new NumericStepper(); addChild(text_A); text_A.x = offsetx+space;  text_A.y = offsety
			text_B = new NumericStepper(); addChild(text_B); text_B.x = offsetx+space; text_B.y = offsety + space + text_A.height;
			text_C = new NumericStepper(); addChild(text_C); text_C.x = offsetx + space; text_C.y = offsety + space * 2 + text_A.height + text_B.height;
			text_D = new NumericStepper(); addChild(text_D); text_D.x = offsetx + space; text_D.y = offsety + space * 3 + text_A.height + text_B.height + text_C.height ;
			
			text_A.stepSize = text_B.stepSize =  0.2; text_C.stepSize = 2
			text_A.minimum = text_B.minimum = text_C.minimum = text_D.minimum = -1000;
			text_A.maximum = text_B.maximum = text_C.maximum = text_D.maximum = 1000;
			
			//draw graph
			graph = new Sprite(); addChild(graph);
			with (graph) {
				graphics.lineStyle(1,0xAAAAAA);
				graphics.moveTo(stage.stageWidth >> 1, 0); graphics.lineTo(stage.stageWidth >> 1, stage.stageHeight);
				graphics.moveTo(0, stage.stageHeight >> 1); graphics.lineTo(stage.stageWidth, stage.stageHeight >> 1);
			}
			var tri1:Triangle = new Triangle(); addChild(tri1); tri1.x = stage.stageWidth * 0.95; tri1.y = stage.stageHeight >> 1;
			var tri2:Triangle = new Triangle(); addChild(tri2); tri2.x = stage.stageWidth >> 1; tri2.y = stage.stageHeight * 0.95;; tri2.rotation = 90;
		}
		
		private function switching(e:MouseEvent):void {
				t.text = "f(x)\t =\t P (x^3)\t +\t Q (x^2)\t +\t R (x) +\t S\n\nP\t=\n\nQ\t=\n\nR\t=\n\nS\t=\n\n";
		}
		
		private function redraw(A:Number, B:Number, C:Number, D:Number):void {
			for (var i:int = 0; i < 400; i++) {
				var x:Number = i - 200;
				points[i * 2] = x * 10 + stage.stageWidth >> 1;
				points[i * 2 + 1] = cubic1(x, A, B, C, D) + stage.stageHeight >> 1
				
				if (i == 0) drawCommand[i] = 1;
				else drawCommand[i] = 2;
			}
			graphics.clear();
			graphics.lineStyle(1);
			graphics.drawPath(drawCommand, points);
		}
		
		private function cubic1(x:Number, A:Number, B:Number, C:Number, D:Number):Number {
			//y = A(x^3) + B(x^2) + C(x) + D
			return A*x*x*x+ B*x*x + C*x +D
		}
		
		public function Graphing2() {
			setup();
			redraw(Number(text_A.value), Number(text_B.value), Number(text_C.value), Number(text_D.value))
			text_A.addEventListener(Event.CHANGE, react);
			text_B.addEventListener(Event.CHANGE, react);
			text_C.addEventListener(Event.CHANGE, react);
			text_D.addEventListener(Event.CHANGE, react);
		}
		
		private function react(e:Event):void {
			redraw(Number(text_A.value), Number(text_B.value), Number(text_C.value), Number(text_D.value))
		}
	}

}