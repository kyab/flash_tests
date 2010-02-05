package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class ControlPain extends Sprite
	{
		private var _btnPlay : MyButton;
		private var _btnStop : MyButton;
		private var _btnGotoBegin : MyButton;
		
		private var _currentPositionDisp : TextField;
		
		private var _song:Song;
		
		public function ControlPain(song:Song)
		{	_song = song;
			if (stage) init();
			else this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null) : void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initUI();
			initListener();
		}
		
		private function initUI() : void {
			_btnPlay = new MyButton(80, 30, "play");
			_btnPlay.x = 10;
			_btnPlay.y = 5;
			this.addChild(_btnPlay);
			
			_btnStop = new MyButton(80, 30, "stop");
			_btnStop.x = _btnPlay.x + _btnPlay.width;
			_btnStop.y = _btnPlay.y;
			this.addChild(_btnStop);

			_btnGotoBegin = new MyButton(80, 30, "<<");
			_btnGotoBegin.x = _btnStop.x + _btnStop.width;
			_btnGotoBegin.y = _btnPlay.y;
			this.addChild(_btnGotoBegin);
			
			_currentPositionDisp = new TextField;
			_currentPositionDisp.background = true;
			_currentPositionDisp.backgroundColor = Color.BLACK;
			_currentPositionDisp.alpha = 0.5;
			with (_currentPositionDisp) {
				var format:TextFormat = new TextFormat;;
				format.align = TextFormatAlign.CENTER;
				format.size = 20;
				format.color = Color.WHITE;
				_currentPositionDisp.defaultTextFormat = format;
				_currentPositionDisp.text = "000000"
			}

			_currentPositionDisp.x = _btnGotoBegin.x + _btnGotoBegin.width;
			_currentPositionDisp.y = _btnPlay.y
			_currentPositionDisp.width = 200;
			_currentPositionDisp.height = 30;
			this.addChild(_currentPositionDisp);
			
			this.graphics.beginFill(Color.GRAY);
			this.graphics.drawRoundRect(0, 0, this.width, 40, 10, 10);
			this.graphics.endFill();
			
		}
		private function initListener() : void {
			_btnPlay.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
				_song.play();
				_btnPlay.enabled = false;
			});
			
			_btnStop.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
				_song.pause();
				_btnStop.enabled = false;
				_btnPlay.enabled = true;
			});
			
			_btnGotoBegin.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
				_song.setPos(0);
			});
		}
	}

}