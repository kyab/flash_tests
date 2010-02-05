package  
{
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public dynamic class Track
	{
		private var _isRecording:Boolean;
		private var _isMuted:Boolean;
		public function Track() 
		{
			
		}
		
		public function mute() {
			_isMuted = true;
		}
		
		public function unMute() {
			_isMuted = false;
		}
		
	}

}