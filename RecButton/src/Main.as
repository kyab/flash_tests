package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
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
			var rButton1:RecButton = new RecButton(200);
			rButton1.x = 10;
			rButton1.y = 10;
			
			var rButton2:RecButton = new RecButton(20);
			rButton2.x = 10;
			rButton2.y = 10 + 200 + 10;
			
			var buttons :Array = new Array(rButton1, rButton2);
			for each (var button:RecButton in buttons){
				button.addEventListener(RecButtonEvent.CHANGED, function(evt:RecButtonEvent):void {
					trace(evt.rec ? evt.target.toString() + ":rec on" : evt.target + "rec off");
				});
				button.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
					trace("recbuton clicked");
				});
				addChild(button);
			}
			/*
			rButton1.addEventListener(RecButtonEvent.CHANGED, function(evt:RecButtonEvent):void {
				trace(evt.rec ? "rec on" : "rec off");
			});
			rButton.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
				trace("recbuton clicked");
			});
			addChild(rButton);
			*/
			
		}
		
	}
	
}