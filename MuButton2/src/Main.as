package 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.display.*;
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	
	public class Main extends Sprite 
	{
		private var btn2:MyButton;
	
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

	
			btn2 = new MyButton(100,30, "hello");
			btn2.x = 30;
			btn2.y = 80;
			btn2.addEventListener(MouseEvent.CLICK, onClick);
			addChild(btn2);
		}
		public function onClick(evt:MouseEvent):void {
			trace("Clicked");
			evt.target.setText("Clicked");
			//btn2.upState.addChild(new TextField("fff"));
		}
	}
}


