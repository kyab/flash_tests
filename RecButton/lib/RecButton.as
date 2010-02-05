package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class RecButton extends Sprite
	{
		private var _size :uint
		private var _backGround:Shape;
		private var _circle:Shape;
		
		private var _rec:Boolean = false;
		
		public function RecButton(size : uint) 
		{
			_size = size;
			this.buttonMode = true;
			addChild(_backGround = new Shape);
			redrawBackGround();
			
			with (_circle = new Shape()) {
				graphics.beginFill(Color.BLACK + 0x222222);	//Brack
				graphics.drawCircle(size / 2, size / 2, size * 0.83 / 2);
				graphics.endFill();
			}
			addChild(_circle);
			
			
			this.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
				//trace("RecButton clicked");
				_rec = !_rec;
				dispatchEvent(new RecButtonEvent(_rec));
				redrawBackGround();
			});
			
		}
		
		private function redrawBackGround() : void {
			with (_backGround) {
				graphics.beginFill(_rec ? Color.RED  : Color.GRAY);
				graphics.drawRect(0, 0, _size, _size);
				graphics.endFill();
				graphics.lineStyle(1);
				graphics.lineTo(_size, 0);
				graphics.lineTo(_size, _size);
				graphics.lineTo(0, _size);
				graphics.lineTo(0, 0);
				
				//本当は時間と共に色を変えて行きたい。TransformやColorTransformを使えばいいみたい。
			}
		}
		
	}

}