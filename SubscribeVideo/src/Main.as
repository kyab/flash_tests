package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	//import mx.controls;
	import fl.controls.Button;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		//ui
		private var video:Video;
		private var textField:TextField;
		
		//network stuff
		private var con:NetConnection;
		private var stream:NetStream;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		

		private function mytrace(message : String) : void {
			var d : Date = new Date;
			var dateStr:String = "[" + d.date + " " + d.hours + ":" + d.seconds + "]";			trace(dateStr + ":" + message);
			textField.appendText(dateStr + message + "\n");
			trace(dateStr + message);
		}
		
		private function onConnectSucccess() : void {
			mytrace("connectd to server");
			stream = new NetStream(con);
			video.attachNetStream(stream);
			stream.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent):void {
					mytrace("streamevent:" + evt.info.code);
				});
			stream.play("video0");
		}
		
		private function connectToServer() : void {
			var serverAddress : String = "rtmp://koji-1/VideoServer";
			
			con = new NetConnection();
			//con.client = this;
			con.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					switch(evt.info.code) {
					case "NetConnection.Connect.Success":
						onConnectSucccess();
						break;
					default:
						mytrace("failed to connect server(" + serverAddress);
						mytrace("...error : " + evt.info.code);
					}
				});
			mytrace("connecting server(" + serverAddress + ")...");
			con.connect(serverAddress);
		}
			
		private function startSubscribeVideo():void {
			connectToServer();
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			initUI();
			startSubscribeVideo();
		}
		
		private function initUI() : void {
			//the video
			video = new Video;
			video.width = 300;
			video.height = video.width * 3 / 4;
			video.x = 0;
			video.y = 10;
			video.opaqueBackground = true;
			video.rotation = 3;
			addChild(video);
			
			//text
			textField = new TextField;
			textField.x = video.x + video.width + 10;
			textField.y = 5;
			textField.background = true;
			textField.backgroundColor = 0xF0f0F0;
			textField.multiline = true;
			//textField.textColor = 0x22FF00;
			textField.width = stage.stageWidth - video.width - 200;
			textField.height = stage.stageHeight -5;
			//stage.scaleMode = "StageScaleMode.SHOW_ALL"
			addChild(textField);
			
			mytrace("stageWidth:" + stage.stageWidth);
			
			btn:Button = new Button;
			addChild(btn);
			
			
		}	
	}
	
}