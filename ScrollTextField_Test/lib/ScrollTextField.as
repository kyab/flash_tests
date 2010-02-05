package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	//TODO 横スクロールバー。
	//TODO:TextField依存をやめたい(内部は単にDisplayObject)をcontentsに持つだけにしたい。
	//TODO:上下キーでアップダウン。
	//TODO stageにaddEventListenerするのをやめたい...。
	//  とりあえず、addEventListener()にてキャプチャ段階でListenし、その段階でdragging状態なら以降のイベント処理をさせないことにする。..とだめでした。（イベント認識しない）
	public class ScrollTextField extends Sprite
	{
		private var _txt:TextField;
		private var _scrollBarArea:Sprite;
		private var _bar: Sprite;
		
		private var _dragging : Boolean = false;
		private var _dragStartPosY : uint = 0;	//drag start pos (y in _bar);
		
		private static const BAR_WIDTH : uint = 20;
		private static const CHANGE_OBSERV_INTERVAL : uint = 200;
		
		public function ScrollTextField(width:uint, height:uint) 
		{
			super();
			
			buildComponents(width,height);
			registerListeners();
		}
		
		public function get txtField():TextField {
			return _txt;
		}
		
		private function buildComponents(width:uint, height:uint):void {
			this.graphics.beginFill(0xEEEEEE);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
			
			//scroll area
			_scrollBarArea = new Sprite;
			_scrollBarArea.graphics.beginFill(0xCCCCCC);
			_scrollBarArea.graphics.drawRoundRect(0, 0, BAR_WIDTH, this.height,10,10);
			_scrollBarArea.graphics.endFill();
			_scrollBarArea.x = this.width - BAR_WIDTH;
			_scrollBarArea.y = 0;
			this.addChild(_scrollBarArea);
			
			//the scroll bar
			_bar = new Sprite();
			_bar.x = 0;
			_bar.y = 0;
			_bar.buttonMode  = true;
			_scrollBarArea.addChild(_bar);
			
			
			//the TextField (contents);
			_txt = new TextField();
			_txt.multiline = true;
			_txt.alwaysShowSelection = true;
			//_txt.border = true;
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.scrollRect = new Rectangle(0, 0, this.width - BAR_WIDTH, this.height);
			this.addChild(_txt);
		}
		
		private function registerListeners():void {
			
			//watch and resize bar periodically.
			//want more better way to detect contents size.
			{
				var tmr : Timer = new Timer(CHANGE_OBSERV_INTERVAL);
				tmr.addEventListener(TimerEvent.TIMER, function (evt:TimerEvent) : void {
					resizeBar();
				});
				tmr.start();
			}
			
			_bar.addEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			_bar.addEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBarArea.addEventListener(MouseEvent.CLICK, onBarAreaMouseClick);
			
			this.addEventListener(Event.ADDED_TO_STAGE, function(evt:Event) :void {
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);					
			});
		}
		
		private function onBarMouseDown(evt:MouseEvent):void {
			if (!_dragging) {
				_dragging = true;
				_dragStartPosY = _bar.mouseY;
			}
		}
		private function onBarMouseUp(evt:MouseEvent):void {
			_dragging = false;
		}
		
		private function onMouseWheel(evt:MouseEvent) : void {
			var wheelRate : int = 1;
			scrollTo(_bar.y - (evt.delta * wheelRate));
		}
		
		private function onBarAreaMouseClick(evt:MouseEvent) : void {
			if (_scrollBarArea.mouseY < _bar.y) {
				scrollTo(_bar.y - (_bar.height - 10));
			}else if (_scrollBarArea.mouseY > _bar.y + _bar.height) {
				scrollTo(_bar.y + (_bar.height -10));
			}
		}
		
		private function onStageMouseMove(evt:MouseEvent) : void {
			if (_dragging) {
				var posInBar: Point = _bar.globalToLocal(new Point(stage.mouseX, stage.mouseY));
				var deltaY:int = posInBar.y - _dragStartPosY;
				
				if ( _bar.y + deltaY < 0) {
					scrollToTop();
				}else if (_bar.y + deltaY + _bar.height > this.height) {
					scrollToBottom();
				}else {
					scrollTo(_bar.y + deltaY);
				}
				evt.stopPropagation();
			}
		}
		
		private function onStageMouseUp(evt:MouseEvent) : void {
			if (_dragging) {
				_dragging = false;
				evt.stopPropagation();
			}
		}
		
		
		//called periodically
		private function resizeBar() : void {
			var contentRatio:Number =  _txt.textHeight / this.height;	//_txt.height does not change. so use textHeight
			if (contentRatio < 1) {
				_bar.graphics.clear();
			}else {
				newBarHeight = this.height * 1/contentRatio;
				_bar.graphics.clear();
				_bar.graphics.beginFill(0x6666FF);
				_bar.graphics.drawRoundRect(0, 0, BAR_WIDTH, newBarHeight, 10, 10);
				_bar.graphics.endFill();
				
			}
		}
		
		private function scrollTo(y:int) : void {
			if (_bar.height == 0) {
				return;
			}
			
			if (y < 0) {
				scrollTo(0);
			}else if ( (y + _bar.height) > this.height) {
				scrollTo(this.height - _bar.height);
			}else {
				_bar.y = y;
				scrollContents();
			}
		}
		public function scrollToTop() : void {
			scrollTo(0);
		}
		
		public function scrollToBottom() : void {
			resizeBar();
			scrollTo(this.height - _bar.height);
		}
		
		//scroll internal contents(TextField) to match current cursor
		//called from scrollTo
		private function scrollContents() : void {
			var rec:Rectangle = _txt.scrollRect;
			var newY:Number = (_txt.textHeight + 10/*+alpha*/) * (_bar.y / this.height); 
			rec.y = int(newY);
			_txt.scrollRect = rec;
		}
		

	}

}