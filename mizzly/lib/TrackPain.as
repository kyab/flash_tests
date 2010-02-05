package  
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public dynamic class TrackPain extends Sprite
	{
		private var _controlPain:TrackControlPain;
		
		public function TrackPain() 
		{
			_controlPain = new TrackControlPain();
			this.addChild(_controlPain);
		}
		
	}

}