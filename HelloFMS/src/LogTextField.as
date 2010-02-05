package  
{
	import flash.display.IBitmapDrawable;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	//keep colod/font size settings
	public /*dynamic*/ class LogTextField extends TextField
	{
		private var format:TextFormat = new TextFormat();
		public function LogTextField ():void {
			//nothing to do
			super();
		}
		public function addLine(message:String): void {
			appendText(message + "\n");
			setTextFormat(format);
		}
		public function setFormat(format:TextFormat) : void {	
			this.format = format;
			setTextFormat(format);
		}
		public function setFormatWithSizeColor(size:int, color:int) :void {
			format.size = size;
			format.color = color;
			setTextFormat(format);
		}
		public function clear():void {
			this.text = "";
			setTextFormat(format);
		}
	}

}