package
{
	import flash.display.Sprite;
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setInterval;

	public class Main extends Sprite {
	
		private var circleA:Sprite;
		private var circleB:Sprite;
		private var xpos:int = 100;
		private var ypos:int = 100;
		
		public function Main() :void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			circleA = new Sprite;
			circleA.graphics.beginFill(0x3399FF);
			circleA.graphics.drawCircle(260, 200, 80);
			circleA.addEventListener(MouseEvent.CLICK, onClick);
			addChild(circleA);
			
			circleB = new Sprite;
			circleB.graphics.beginFill(0xFF3333);
			circleB.graphics.drawCircle(340, 260, 80);
			circleB.addEventListener(MouseEvent.CLICK, onClick);
			addChild(circleB);
			
			var animatedHello : AnimatedHelloWorld = new AnimatedHelloWorld;
			animatedHello.x = 100;
			addChild(animatedHello);
			trace("hello");
			
		}
		
		public function onClick(event:MouseEvent):void {
			trace("clicked");
			var txt:TextField = new TextField;
			if (event.target == circleB) {
				txt.text = "CircleB!!";
			}else {
				txt.text = "CircleA";
			}
			txt.x = xpos;
			txt.y = ypos;
			xpos = xpos + 10;
			ypos = ypos + 10;

			addChild(txt);
		}
	}
}