package  
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public dynamic class Song extends EventDispatcher
	{
		private var current:uint;			//現在再生中の位置(ミリ秒)
		private var isRecording:Boolean;
		
		public function Song() 
		{
			
		}
		
		public function play() : void {
			trace("play");
		}
		
		
		public function pause() : void {
			trace("pause");
			;
		}
		
		public function get currentPos() : uint {
			return current;
		}
		
		public function setPos(pos:uint) : void {
			current = pos;
		}
	}

}