package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		//UI(Controller)
		private var btnPlay:MyButton = new MyButton(100, 20, "play");
		private var btnStop:MyButton = new MyButton(100, 20, "stop");
		private var btnBack:MyButton = new MyButton(100, 20, "back");
		
		//Model State
		private const PLAYING : uint = 1;
		private const STOPPED : uint = 0;
		private var state:uint = STOPPED;
		private var songLength:uint = 60 * 1000;	//song is 1 minutes length.
		private var currentPos:uint = 0;			//current position in msec.
		
		//View
		private var timeLineView:Sprite;
		private var disp:TextField;
		private var barCurrentPos : Sprite;			
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function setDispText(caption:String):void {
			disp.text = caption;
			var newFormat : TextFormat = new TextFormat();
			newFormat.size = 16;
			newFormat.color = 0xFFFFFF;
			newFormat.align = TextFormatAlign.CENTER;
			disp.setTextFormat(newFormat);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			disp =  MyButton.centerdText("TimeLine DEMO!!");
			addChild(disp);
			with (disp){
				width = 460;
				height = 30;
				background = true;
				backgroundColor = 0x111111;
				var newFormat : TextFormat = new TextFormat();
				newFormat.size = 16;
				newFormat.color = 0xFFFFFF;
				setTextFormat(newFormat);
				
				x = (stage.stageWidth - disp.width) / 2;
				y = 5;
			}			
			
			timeLineView = new Sprite;
			addChild(timeLineView);
			with(timeLineView){
				graphics.beginFill(0xADD8E6);	//Light Blue
				graphics.drawRect(0, 0, 460, 150);
				graphics.endFill();
				x = (stage.stageWidth - timeLineView.width) / 2;
				y = 40;
			}
			
			barCurrentPos = new Sprite;
			barCurrentPos.graphics.lineStyle(2);
			barCurrentPos.graphics.lineTo(0, 100);
			barCurrentPos.x = 10;
			barCurrentPos.y = 10;
			timeLineView.addChild(barCurrentPos);
			
			var controllerPanel:Sprite = new Sprite;
			with (controllerPanel) {
				x = timeLineView.x;
				y = timeLineView.y + timeLineView.height + 15;
				addChild(btnPlay);
				addChild(btnStop);
				addChild(btnBack);
				
				btnPlay.x = 10;
				btnPlay.y = 5;
				btnPlay.addEventListener(MouseEvent.CLICK, onClickPlay);
				
				btnStop.x = btnPlay.x + btnPlay.width + 15;
				btnStop.y = btnPlay.y;
				btnStop.addEventListener(MouseEvent.CLICK, onClickStop);
				
				btnBack.x = btnStop.x + btnStop.width + 15;
				btnBack.y = btnPlay.y;
				btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
					
			}
			addChild(controllerPanel);
		
			var timer:Timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		private function onClickPlay(evt:MouseEvent): void {
			state = PLAYING;
			//setDispText("Playing");
		}
		private function onClickStop(evt:MouseEvent) : void {
			state = STOPPED;
			//setDispText("Click Play to play");
		}
		private function onClickBack(evt:MouseEvent) : void {
			currentPos = 0;
			onCurrentPosChanged();
		}
		
		private function onCurrentPosChanged(): void {
			barCurrentPos.x = (currentPos / songLength) * timeLineView.width;
			var currentTimeString : String = "";
			currentTimeString += (currentPos / 1000).toString();
			setDispText(currentTimeString);
		}
		private function onTimer(evt:TimerEvent) : void {
			if (state == PLAYING) {
				var x:uint;
				currentPos = currentPos + 50;//TODO: rely on system time. not timer interval.
				onCurrentPosChanged();
			}
		}
		
	}
	
}