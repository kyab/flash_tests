package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 * Testing gauge class
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
			
			//tiny text field which display current value
			var valueText:TextField = new TextField();
			valueText.x = 100 + 200 + 10;
			valueText.y = 95;
			valueText.width = 40;
			valueText.defaultTextFormat = new TextFormat("Arial", 20, Color.PURPLE,null,null,null,null,null,TextFormatAlign.RIGHT);
			addChild(valueText);
			
			var gauge:Gauge = new Gauge(200, 20, Color.RED)
			var gauge2:Gauge = new Gauge(300, 10, Color.LIGHTBLUE);
			
			gauge.x = 100;
			gauge2.x = 20;
			gauge.y = 100;
			gauge2.y = 130;
			
			this.addChild(gauge);
			this.addChild(gauge2);
			
			gauge.value = 100;
			
			
			//update value in some interval
			var isUpping:Boolean = false;
			var skipCount:int = 0;
			var timer:Timer = new Timer(20);
			timer.addEventListener(TimerEvent.TIMER, function(evt:TimerEvent):void {
				if (skipCount > 0) {
					skipCount-- ;
					return;		//skip
				}
				var newVal:int;
				if (isUpping) {
					newVal = gauge.value + 2;
					if (newVal > 100) {
						isUpping = false;
						skipCount = 100;
					}else {
						gauge.value = newVal;
						gauge2.value = newVal;
						valueText.text = gauge.value.toString();
					}
				}else {
					newVal = gauge.value - 20;
					if ( newVal < 0) {
						isUpping = true;
						skipCount = 100;
					}else {
						gauge.value = newVal;
						gauge2.value = newVal;
						valueText.text = gauge.value.toString();
					}
				}
			});
			timer.start();	
			
		}
		
	}
	
}