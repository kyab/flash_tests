package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 * Currently this is the view and controller 
	 */
	public class Main extends Sprite 
	{
		private var _controlPain : ControlPain;
		private var _songPain : SongPain;
		
		private var _song : Song;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_song = new Song();
			
			
			_controlPain = new ControlPain(_song);
			_controlPain.x = 100;
			_controlPain.y = 10;
			addChild(_controlPain);
			
			_songPain = new SongPain();
			_songPain.x = 10;
			_songPain.y = _controlPain.y + 50;
			addChild(_songPain);

		}
		
	}
	
}