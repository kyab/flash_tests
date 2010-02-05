package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class DropdownListEvent extends Event 
	{
		public static const ITEM_CHANGED : String = "DropdownListEvent.ITEM_CHANGED";
		private var _text: String
		public function DropdownListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		public function set text(str:String):void {
			_text = str;
		}
		//text of selected item
		public function get text() : String {
			return _text;
		}
		
		public override function clone():Event 
		{ 
			return new DropdownListEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DropdownListEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}