package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		//ui
		private var audio:SoundTransform;
		//private var video:Video;
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
		
		private function onConnectSucccess(serverAddress:String) : void {
			mytrace("connectd to server : " + serverAddress);
			
			stream = new NetStream(con);
			
			audio = stream.soundTransform;
			var myAudio:SoundTransform = new SoundTransform(100);
			stream.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent):void {
					mytrace("streamevent:" + evt.info.code);
				});
				
			//myAudio.addEventListener(NE
			stream.play("audio_1");
			stream.receiveVideo(false);
			stream.bufferTime = 0;
			mytrace("stream live delay:"  + stream.liveDelay);
			mytrace("audio volume:" +  myAudio.volume);
		
		}
		
		private function connectToServer() : void {
			var serverAddress : String = "rtmp://koji-1/AudioServer/MyInstance";
			
			con = new NetConnection();
			//con.client = this;
			con.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					switch(evt.info.code) {
					case "NetConnection.Connect.Success":
						onConnectSucccess(serverAddress);
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

			//text(trace frame)
			textField = new TextField;
			textField.x = 10;
			textField.y = 5;
			textField.background = true;
			textField.backgroundColor = 0xF0f0F0;
			textField.multiline = true;
			textField.width = stage.stageWidth - 200;
			textField.height = stage.stageHeight -5;
			addChild(textField);
		
			mytrace("SubscriveAudio");
		}	
	}
}