package 
{
	// Publish video!!
	import flash.display.Sprite;
	import flash.events.*; 
	import flash.media.*;
	import flash.net.*;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		//ui
		private var camera:Camera;
		private var textField:TextField;
		private var button : MyButton;
		
		//network
		private var con:NetConnection;
		private var stream:NetStream;
		
		private var camera_activated:Boolean = false;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function mytrace(message : String) : void {
			var d : Date = new Date;
			var dateStr:String = "[" + d.date + " " + d.hours + ":" + d.seconds + "]";	
			trace(dateStr + ":" + message);
			textField.appendText(dateStr + message + "\n");
		}
		
		//server call close() if connection failed.
		public function close() : void {
			mytrace("closed from server");
		}
		
		private function startPublish() : void {
			stream = new NetStream(con);
			stream.attachCamera(camera);
			stream.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					mytrace("netstream event:" + evt.info.code);
				});
			stream.publish("video0");
		}

		private function onConnectSuccess() : void {
			mytrace("connected to server");
			startPublish();
		}
		
		
		private function connectToServer() : void {
			var serverAddress : String = "rtmp://koji-1/VideoServer";
			
			con = new NetConnection();
			con.client = this;
			con.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					switch(evt.info.code) {
					case "NetConnection.Connect.Success":
						onConnectSuccess();
						break;
					default:
						mytrace("failed to connect server(" + serverAddress + ")");
						mytrace("...error = " + evt.info.code);
					}
				});
			mytrace("connecting...");
			con.connect(serverAddress);
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//camera
			camera = Camera.getCamera();
			if (camera == null) {
				mytrace("camera not found");
				return;
			}
			camera.addEventListener(StatusEvent.STATUS, 
				function(evt:StatusEvent):void {
					switch(evt.code) {
					case "Camera.Unmuted":
						mytrace("camera access allowed");
						break;
					case "Camera.Muted":
						mytrace("camera access denied");
						break;
					default:
						mytrace("unknown camera status event:" + evt.code);
					}
				});
			
			camera.addEventListener(ActivityEvent.ACTIVITY,
				function(evt:ActivityEvent):void {
					if (!camera_activated) {
						mytrace("detect camera activity:" + evt.activating);
						camera_activated = true;
						connectToServer();
					}
					//camera.removeEventListener(ActivityEvent.ACTIVITY,arguments.callee);
				});
			
			camera.setMode(300, 300*3/4, 30);
			camera.setQuality(2 * 1024 * 1024, 0); //use super high quality
			var video:Video = new Video(camera.width, camera.height);
			video.attachCamera(camera);
			video.x = 0;
			video.y = 100;
			addChild(video);
			
			button = new MyButton(100, 30, "hogehoge");
			addChild(button);
			
			var txt : TextField = new TextField;
			txt.text = "hello";
			addChild(txt);
			
			
			//textFiled for trace
			textField = new TextField;
			textField.x = video.x + video.width + 10;
			textField.y = 5;
			textField.background = true;
			textField.multiline = true;
			textField.backgroundColor = 0xC0C0C0;
			//textField.textColor = 0x22FF00;
			textField.width = stage.stageWidth - video.width - 200;
			textField.height = stage.stageHeight -5;
			//stage.scaleMode = "StageScaleMode.SHOW_ALL"
			addChild(textField);
			
			mytrace("stageWidth:" + stage.stageWidth);
			
			//カメラが準備できてからstream開始するので、ここでは何もしない。
		}
		
	}
	
}