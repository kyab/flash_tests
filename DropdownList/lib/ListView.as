package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 * ListView is a class which display selectable item;
	 */
	public class ListView extends Sprite
	{
		private var _itemCount:uint = 0;
		private var _width:uint;
		public function ListView(width:uint) 
		{
			_width = width;
		}
		
		public function addItem(text:String) : void {
			_itemCount += 1;
			var newItem : ListItemView = new ListItemView(text, _width);
			newItem.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
				onItemClicked(evt.target as ListItemView);
			});
			newItem.y = _itemCount * 20;
			addChild(newItem);
		}
		
		private function onItemClicked(item:ListItemView):void {
			var dropDown : DropdownList = this.parent as DropdownList;
			var prevText : String = dropDown.text;
			dropDown.text = item.text;
			
			//dispatch DropdownListEvent.ITEM_CHANGED only if selection changed!
			if (prevText != item.text) {
				var changeEvent:DropdownListEvent = new DropdownListEvent(DropdownListEvent.ITEM_CHANGED);
				changeEvent.text = item.text;
				dropDown.dispatchEvent(changeEvent);
			}
			
			//hide this view.
			dropDown.removeChild(this);

		}
	}

}