package  
{
	import flash.display.Shape;
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
		
		private var upText : TextField = null;
		private var overText : TextField = null;
		private var downText : TextField = null;
		
		private var caption : String;
		
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
		private function borderdRect(_width:uint, _height:uint, 
												_color:uint, _borderWidth:uint):Sprite {
			var sprite:Sprite = new Sprite();
			with (sprite) {
				graphics.beginFill(_color);
				graphics.drawRect(0, 0, _width, _height);
				graphics.endFill();
				graphics.lineStyle(_borderWidth);
				graphics.lineTo(_width, 0);
				graphics.lineTo(_width, _height);
				graphics.lineTo(0, _height);
				graphics.lineTo(0, 0);
			}
			return sprite;
		}	
		
		public function MyButton(_width:uint, _height:uint, _caption:String) 
		{
			super();
			init(_width, _height, _caption);
		}
		
		public function init(_width:uint, _height:uint, caption:String) : void
		{
			var faceColor : uint = 0xEEBBBCC;
			
	
			this.upState = borderdRect(_width, _height, faceColor, 2);
			this.overState = borderdRect(_width, _height, faceColor + 0x101010, 2);			
			this.downState = borderdRect(_width, _height, faceColor - 0x101010, 2);
			this.hitTestState = borderdRect(_width, _height, faceColor, 1);
			setText(caption);
		}
		
		
		public function setText(caption:String) : void {
			if (upText) {
				upState.removeChild(upText);
			}
			upText = centerdText(caption);
			upState.addChild(upText);
			
			if (downText) {
				downState.removeChild(downText);
			}
			downText = centerdText(caption);
			downState.addChild(downText);
			
			if (overText) {
				overState.removeChild(overText);
			}
			overText = centerdText(caption);
			overState.addChild(overText);
			
			//trace("setText");
		}
	}

}