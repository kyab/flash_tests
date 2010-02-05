package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Main extends Sprite 
	{
		private static const  GRAVITY : Number = 9.8*0.00005;	//重力加速度×係数
		private var _velocity:Number;
		private var _elapsed_time:uint;
		
		private var _timer:Timer;
		private var _point:Shape;
		private var _point2:Shape;

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_timer = new Timer(10);
			_point = new Shape();
			_point2 = new Shape();
			new Array(_point, _point2).forEach(function(point:Shape, index:int, _:Array):void {
				with (point) {
					graphics.beginFill(0x00FF00);
					graphics.drawCircle(0, 0, 10);
					graphics.endFill();
					x = 100 * (index + 1);
					y = 10;
				}
				addChild(point);
			});

			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.addEventListener(TimerEvent.TIMER, onTimer2);
			
			_velocity = 0;
			_elapsed_time = 0;
			_timer.start();		
		}
		
		//積算
		private function onTimer(evt:TimerEvent = null):void {
			//trace("ontimer");
			if (_point == null) {
				trace("NULL");
			}
			_velocity +=  GRAVITY * _timer.delay;
			var distance:Number = _velocity * _timer.delay;
			_point.y += distance;
			
			if (_point.y > stage.stageHeight) {
				reset();
			}
		}
		
		//方程式ベース。位置 =1/2 * GRAVITY * t^2
		// see http://www12.plala.or.jp/ksp/formula/physFormula/html/node4.html
		private function onTimer2(evt:TimerEvent = null):void {
			
			_elapsed_time += _timer.delay;
			
			//位置 =1/2 * GRAVITY * t^2
			var position : Number = 1 / 2 * GRAVITY * _elapsed_time * _elapsed_time;
			_point2.y = position + 10;
			
			if (_point2.y > stage.stageHeight) {
				reset();
			}
		}
		
		//位置や早さ、経過時間をリセット
		private function reset():void {
			_velocity = 0;
			_elapsed_time = 0;
			_point.y = _point2.y = 10;
		}
		
	}
	
}