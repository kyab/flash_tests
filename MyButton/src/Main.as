//MyButton.as
// Test Project for Button Like Sprite 

package 
{
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;

	/**
	 * ...
	 * @author K.Yoshioka
	 */
	
	//add [obj] as child and return itself(for chaining).
	Sprite.prototype.withChild = function (obj:DisplayObject): Sprite {
		this.addChild(obj);
		return this;
	}
	 
	public class Main extends Sprite 
	{
		private var btn1:SimpleButton;
		private var btn2:SimpleButton;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//create textField with caption. text aligh is center
		private function centerdText(caption:String) : TextField{
			var txt:TextField = new TextField();
			txt.text = caption;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			txt.setTextFormat(format);
			
			return txt;
		}
		
		//create RectAngled Sprite with border and color
		private function borderdRect(width:uint, height:uint, 
												color:uint, borderWidth:uint):Sprite {
			var sprite:Sprite = new Sprite();
			with (sprite) {
				graphics.beginFill(color);
				graphics.drawRect(0, 0, width, height);
				graphics.endFill();
				graphics.lineStyle(borderWidth);
				graphics.lineTo(width, 0);
				graphics.lineTo(width, height);
				graphics.lineTo(0, height);
				graphics.lineTo(0, 0);
			}
			return sprite;
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var faceColor : uint = 0xAABBCC;
			
			btn1 = new SimpleButton();
			with (btn1) {
				upState   = borderdRect(100, 30, faceColor, 1).
								withChild(centerdText("Click me"));
				overState = borderdRect(100, 30, faceColor + 0x101010, 2).
								withChild(centerdText("Click me"));
				downState = borderdRect(100, 30, faceColor - 0x101010, 2).
								withChild(centerdText("Click me"));
				hitTestState = borderdRect(100,30,faceColor,1);
				x = 30;
				y = 30;
				addEventListener(MouseEvent.CLICK, onClick);
			}
			this.addChild(btn1);
			
			faceColor = 0xEFEF10;
			btn2 = new SimpleButton();
			with(btn2) {
				upState = borderdRect(100, 20, faceColor, 1).
								withChild(centerdText ("Click 2"));
				overState = borderdRect(100, 20, faceColor + 0x101010, 2).
								withChild(centerdText ("Click 2"));
				downState = borderdRect(100, 20, faceColor - 0x101010, 2).
								withChild(centerdText ("Click 2"));
				hitTestState = borderdRect(100, 20, faceColor, 1);
				x = 30;
				y = 90;
				addEventListener(MouseEvent.CLICK, onClick);
			}
			this.addChild(btn2);
			
		}
		
		private function onClick(event:MouseEvent) : void {
			trace("Button Clicked");
		}
	}
	
}