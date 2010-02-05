package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var listBox : CurrentItemView = new CurrentItemView(80);
			listBox.x  = 20;
			listBox.y = 20;
			//this.addChild(listBox);
			
			var itemView : ListItemView = new ListItemView("mic 1", 80);
			itemView.x = 20;
			itemView.y = 20;
			this.addChild(itemView);
			
			/*
			var listView:ListView = new ListView(80);
			listView.addItem("MIC 1");
			listView.addItem("MIC 2");
			listView.addItem("MIC 3");
			listView.x = 20;
			listView.y = 50;
			this.addChild(listView);
			*/
			
			var dropDown:DropdownList = new DropdownList(160);
			dropDown.x = 20;
			dropDown.y = 140;
			for (var i:int = 1 ; i < 7; i++) {
				dropDown.addItem("MIC " + i.toString());
			}
			dropDown.addEventListener(DropdownListEvent.ITEM_CHANGED, function (evt:DropdownListEvent) : void {
				trace("in main: detect item changed to : " + evt.text);
			});
			this.addChild(dropDown);

		}
		
	}
	
}