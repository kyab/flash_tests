package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class RecButtonEvent extends Event
	{
		public static const CHANGED:String = "RecButtonEvent.CHANGED";
		public var rec:Boolean;
		
		public function RecButtonEvent(rec:Boolean) 
		{
			super(CHANGED);
			this.rec = rec;
			
		}
		public override function clone(): Event {
			return new RecButtonEvent(this.rec);
		}
		
	}

}