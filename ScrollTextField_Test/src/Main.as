package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var t : ScrollTextField = new ScrollTextField(200,300);
			t.txtField.appendText("hoge\n");
			t.x = 120;
			addChild(t);
			
			var btn:MyButton = new MyButton(100, 20, "click me");
			btn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent): void {
				trace("click");
				t.txtField.appendText("click\n");
				t.scrollToBottom();
			});
			btn.x = 20;
			btn.y = 100;
			addChild(btn);
		}
		
	}
	
}