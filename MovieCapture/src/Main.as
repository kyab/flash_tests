package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.*;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	
	[SWF(backgroundColor=0x223344)]
	public dynamic class Main extends Sprite 
	{
		private var statusField:TextField = new TextField;
		private var camera:Camera;
		private var t:Timer;
		
		public function Main():void 
		{
			statusField.x = 500;
			statusField.autoSize = TextFieldAutoSize.LEFT;
			
			camera = Camera.getCamera();
			if (camera == null) {
				statusField.text = "カメラが見つかりません";
				var format:TextFormat = new TextFormat;
				format.color = 0xFFFFFF;
				format.size = 14;
				statusField.setTextFormat(format);
				return;
			}
			
			statusField.text = "camera Found";
			camera.addEventListener(StatusEvent.STATUS, statusHandler);
			camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
			
			camera.setMode(300, 300 * 3 / 4, 30, true);// * 1.5;
			//camera.setQuality(0, 100);
			//camera.setKeyFrameInterval(1);
			var video:Video = new Video(camera.width * 1.5,camera.height*1.5);
			video.attachCamera(camera);
			
			video.y = 0;
			video.x = 0;
			addChild(video);
			addChild(statusField);
			
			t = new Timer(100);
			t.addEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		private function timerHandler(event:TimerEvent) : void {
			var tf:TextField = statusField;
			var cam:Camera = camera;
			
			var format:TextFormat = new TextFormat;
			format.color = 0xFFFFFF;
			format.size = 14;
			tf.text = "";
			tf.appendText("activityLevel: " + cam.activityLevel + "\n"); 
			tf.appendText("bandwidth: " + cam.bandwidth + "\n"); 
			tf.appendText("currentFPS: " + cam.currentFPS + "\n"); 
			tf.appendText("fps: " + cam.fps + "\n"); 
			tf.appendText("keyFrameInterval: " + cam.keyFrameInterval + "\n"); 
			tf.appendText("loopback: " + cam.loopback + "\n"); 
			tf.appendText("motionLevel: " + cam.motionLevel + "\n"); 
			tf.appendText("motionTimeout: " + cam.motionTimeout + "\n"); 
			tf.appendText("quality: " + cam.quality + "\n"); 
			tf.setTextFormat(format);
		}

		private function statusHandler(evt:StatusEvent):void {
			trace("statusHandler");
			//statusField.appendText(":activated");
			//t.start();
			trace(evt.code);	//設定で許可にしてしまうと、これは出てこない
			camera.removeEventListener(StatusEvent.STATUS, statusHandler);
		}
		
		private function activityHandler(evt:ActivityEvent):void {
			trace("activity handler");
			t.start();
			camera.removeEventListener(ActivityEvent.ACTIVITY, activityHandler);
		}
	}
	
}