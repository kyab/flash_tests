package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class CurrentItemView extends Sprite
	{
		private var txt : TextField ;
		private var downArrow : Sprite;
		private var downArrowBorder : Sprite;
		
		private var _width : uint;
		public function CurrentItemView(width:uint) 
		{
			_width = width;
			graphics.beginFill(Color.WHITE);
			graphics.drawRect(0, 0, width, 20);
			graphics.endFill();
			graphics.lineStyle(1);
			graphics.lineTo(width, 0);
			graphics.lineTo(width, 20);
			graphics.lineTo(0, 20);
			graphics.lineTo(0, 0);
			
			txt = new TextField()
			with (txt) {
				var format:TextFormat = new TextFormat();
				format.font = "Arial";
				txt.defaultTextFormat = format;
				txt.width = _width;
				txt.text = "NOTHING SELECTED";
				txt.selectable = false;
				
			}
			addChild(txt);
			
			downArrowBorder = new Sprite();
			with (downArrowBorder) {
				graphics.lineStyle(2,Color.BLACK);
				graphics.lineTo(20, 0);
				graphics.lineTo(20, 20);
				graphics.lineTo(0, 20);
				graphics.lineTo(0, 0);
				graphics.endFill();
				alpha = 0;
			}
			
			downArrow = new Sprite();
			with (downArrow) {
				graphics.beginFill(Color.GRAY);
				graphics.drawRect(0, 0, 20, 20);
				graphics.beginFill(Color.BLACK);
				graphics.lineStyle(1);
				graphics.moveTo(5, 5);
				graphics.lineTo(15, 5);
				graphics.lineTo(10, 15);
				graphics.lineTo(5, 5);
				graphics.endFill();
			}
			downArrow.x = _width - 20;
			addChild(downArrow);
			
			downArrow.addChild(downArrowBorder);
			
			downArrow.addEventListener(MouseEvent.ROLL_OVER, function(evt:MouseEvent) : void {
				//trace("over");
				downArrowBorder.alpha = 1;
			},false);
			
			downArrow.addEventListener(MouseEvent.ROLL_OUT, function(evt:MouseEvent) : void {
				//trace("out");
				downArrowBorder.alpha = 0;
			});
			
		}
		
		public function get text():String {
			return txt.text;
		}
		
		public function set text(str:String) : void {
			txt.text = str;
		}
	}

}