package  
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 *  ListItemView is a each item view in ListView
	 */
	public class ListItemView extends SimpleButton
	{
		private var _width:uint;
		private var _txt:String;
		
		private function createTextField(txt:String,  backgroundColor:uint, width:uint, height:uint) : DisplayObject {
			var textField:TextField = new TextField;
			var format: TextFormat = new TextFormat();
			format.font = "Arial";
			textField.defaultTextFormat = format;
			textField.selectable = false;
			
			textField.text = txt;
			textField.width = width;
			textField.height = height;
			textField.background = true;
			textField.backgroundColor = backgroundColor; 

			return textField;
		}

		public function ListItemView(txt:String,  width:uint) {
			_width = width;
			_txt = txt;
			this.upState =  createTextField(_txt, Color.WHITE, _width, 20);
			this.overState = createTextField(_txt, Color.LIGHTSILVER, _width, 20);
			this.downState = createTextField(_txt, Color.WHITE, _width, 20);
			this.hitTestState =  createTextField(_txt, Color.WHITE, _width, 20);
		}
		public function get text() : String {
			return _txt;
		}	
	}

}