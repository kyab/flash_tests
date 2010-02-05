package  
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	Sprite.prototype.withChild = function (obj:DisplayObject): Sprite {
		this.addChild(obj);
		return this;
	}
	 
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public dynamic class MyButton extends SimpleButton
	{
		private var btn_text : TextField;
		
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
		
		public function MyButton(width:uint, height:uint, caption:String) 
		{
			var faceColor : uint = 0xAABBCC;
			btn_text = centerdText(caption);
			this.upState = borderdRect(width, height,faceColor, 1).
								withChild(btn_text);
			this.overState = borderdRect(width, height, faceColor + 0x101010, 2).
								withChild(btn_text);
			this.downState = borderdRect(width, height, faceColor - 0x101010, 2).
								withChild(btn_text);		
			this.hitTestState = borderdRect(width, height, faceColor, 1);
		}
		
		public function setText(caption:String) : void {
			btn_test.text = caption;
		}
	}

}