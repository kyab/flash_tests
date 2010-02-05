package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class DropdownList extends Sprite
	{
		private var _currentItemView:CurrentItemView;
		private var _listView:ListView;
		
		private var _width:uint;
		public function DropdownList(width:uint) 
		{	
			_width = width;
			_listView = new ListView(_width);
			
			_currentItemView = new CurrentItemView(_width);
			addChild(_currentItemView);

			_currentItemView.addEventListener(MouseEvent.CLICK, onCurrentViewClick);
		}
		private function onCurrentViewClick(evt:MouseEvent):void {
			toggleListView();
		}
		private function toggleListView() : void {
			if (this.getChildByName(_listView.name)) {
				this.removeChild(_listView);
			}else {
				this.addChild(_listView);
			}
		}
		
		public function addItem(str:String) : void {
			_listView.addItem(str);
		}
		public function set text(str:String): void {
			_currentItemView.text = str;
		}
		public function get text():String {
			return _currentItemView.text;
		}
		
		public function select(index:int) : void {
			//;....
		}
	}

}