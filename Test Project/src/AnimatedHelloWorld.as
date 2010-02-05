package  
{
	import flash.display.Sprite;
	import flash.display.*;
	import flash.utils.setInterval;
	import flash.text.*;
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class AnimatedHelloWorld extends Sprite
	{
		
		public function AnimatedHelloWorld() 
		{			
			var txtAnimated:TextField = new TextField();

			txtAnimated.text = "Hello World";
			
			addChild(txtAnimated);
			
			var str:String = txtAnimated.text;
			var len:int = 0;
			
			setInterval(function():void {
				txtAnimated.text = str.substr(0, len);
				len = (len % str.length) + 1;
				var format: TextFormat = new TextFormat;
				format.size = 20;
				format.color = 0x223344;
				txtAnimated.width = 400;
				txtAnimated.setTextFormat(format);
				trace("hello");
			},100);
			
		}
		
	}

}