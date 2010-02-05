package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Gauge extends Sprite
	{
		private var _value:uint;
		
		//_peakValueは一番最近の最大値。
		// 時間経過と共に、
		//_peakValueから0に向かって、加速度的に_currentPeakBarPosを減少させていく。
		//_valueが変更されて_peakValueを超えた場合は、_peakValueも_currentPeakBarPosもリセットする。
		private var _peakValue: uint;
		private var _currentPeakBarPos : uint;
		//private var _peakDownAccel: Number;
		
		private var _valueRect:Shape;
		private var _peakValueBar:Shape;
		
		private var _width:uint;
		private var _height:uint;
		private var _color:uint;		//color of value bar
		
		public function Gauge(width:uint, height:uint, color:uint) 
		{
			_value = _peakValue = 0;
			_peakDownAccel = 0;
			_width = width;
			_height = height;
			_color = color;
			
			//draw background(with black)
			var _back:Shape = new Shape;
			with(_back){
				graphics.beginFill(Color.BLACK);
				graphics.drawRect(0, 0, _width, _height);
				graphics.endFill();
			}
			this.addChild(_back);
			
			//init valueRect:
			_valueRect = new Shape();
			with(_valueRect){
				_valueRect.graphics.beginFill(_color);
				_valueRect.graphics.drawRect(0, 0, _width, _height);
				_valueRect.graphics.endFill();
			}
			this.addChild(_valueRect);
			
			//init _maxValueBar;
			_peakValueBar = new Shape();
			with (_peakValueBar) {
				graphics.beginFill(Color.YELLOW);
				graphics.drawRect(0, 0, 5, _height);
				graphics.endFill();
			}
			addChild(_peakValueBar);
			
			//
			var timer : Timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, function(evt:TimerEvent):void {
				updatePeakBar();
			});
			timer.start();
			
			//一行で書くテスト
			/*
			each_interval(50, function():void {
				updatePeakBar();
			});
			
			function each_interval(interval:uint, func:Function) {
				var timer : Timer = new Timer(interval);
				timer.addEventListener(TimerEvent.TIMER, function(evt:TimerEvent):void {
					func();
				});
				timer.start();
			}*/
			
			
		}
		
		public function get value():uint {
			return _value;
		}
		public function set value(val:uint):void {
			_value = val;
			if (_value >= _peakValue) {
				_peakValue = _value;
				_peakValueBar.x =  _peakValue / 100 * _width;
				_peakDownAccel = 0.1;
			}else {
				
			}
			updateValuRect();
			//dispatchEvent(GaugeEvent.UPDATE,,,);
		}
		private function updateValuRect() : void {
			_valueRect.scaleX = _value / 100.0;
		}
		private function updatePeakBar() : void {
			trace("------");
			
		//_peakValueは一番最近の最大値。
		// 時間経過と共に、
		//_peakValueから0に向かって、加速度的に_currentPeakBarPosを減少させていく。
		// 0,1,2,4,8,16,32,,,,
		//_valueが変更されて_peakValueを超えた場合は、_peakValueも_currentPeakBarPosもリセットする。
		// _currentPeakBarPosは_peakBar.xと同じだから、変数としては不要かもしれない。。

		} 
		
	}

}