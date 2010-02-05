package  
{
	import flash.display.Sprite;
	import flash.events.Event;

	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public dynamic class TrackControlPain extends Sprite
	{
		
		public function TrackControlPain() 
		{
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		private function init(_:Event = null) : void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//background
			var back:Sprite = new Sprite();
			with (back) {
				graphics.beginFill(Color.WHITE);
				graphics.drawRoundRect(0, 0, 120, 80, 10, 10);
				graphics.endFill();
			}
			addChild(back);
			
			var recButton:RecButton = new RecButton(20);
			recButton.x = this.width - 22;
			recButton.y = this.height - 22;
			addChild(recButton);
			
		}
	}

}