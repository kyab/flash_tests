package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
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
			
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(3);
			sprite.graphics.beginFill(0xFFFF00);
			sprite.graphics.drawRect(100, 100, 100, 100);
			sprite.graphics.endFill();
			addChild(sprite);
			
			var blur:BlurFilter = new BlurFilter(5,5, 3);
			var filters:Array = new Array();
			filters.push(blur);
			sprite.filters = filters;
			
		}
		
	}
	
}