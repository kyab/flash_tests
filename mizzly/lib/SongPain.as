package  
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public dynamic class SongPain extends Sprite
	{
		private var _trackPain1:TrackPain;
		public function SongPain() 
		{
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		private function init(e:Event = null) :void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var shape:Shape = new Shape();
			with (shape){
				graphics.beginFill(Color.GRAY);
				graphics.drawRect(0, 0, 700, 400);
				graphics.endFill();
			}
			addChild(shape);
			
			_trackPain1 = new TrackPain();
			addChild(_trackPain1);
		}
	}
	

}
	import flash.display.Sprite;
	class Hoge extends Sprite
	{
		public function Hoge() {
			trace("Hoge::Hoge");
		}
	}


