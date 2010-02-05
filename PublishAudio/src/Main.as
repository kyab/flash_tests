package 
{
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.media.*;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.system.System;
	import flash.text.*;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		//the mic
		private var mic:Microphone;
		
		//the trace window
		private var textField:TextField = null;
		private var volumeMeter:TextField = null;
		
		
		//network stuff
		private var con:NetConnection;
		private var stream:NetStream;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function mytrace(message : String) : void {
			if (textField == null) {
				textField = new TextField;
				textField.x = 100;
				textField.y = 100;
				textField.background = true;
				textField.multiline = true;
				textField.backgroundColor = 0xC0C0C0;
				textField.width = stage.stageWidth - 100;
				textField.height = stage.stageHeight - 5;
				addChild(textField);
			}
			var d : Date = new Date;
			var dateStr:String = "[" + d.date + " " + d.hours + ":" + d.seconds + "]";
			trace(dateStr + ":" + message);
			textField.appendText(dateStr + message + "\n");
		}
		
		private function connectToServer() : void {
			var serverAddress : String = "rtmp://koji-1/AudioServer/MyInstance";
			
			con = new NetConnection();
			con.client = this;
			con.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					switch(evt.info.code) {
					case "NetConnection.Connect.Success":
						onConnectSuccess(serverAddress);
						break;
					default:
						mytrace("failed to connect server(" + serverAddress + ")");
						mytrace("...error = " + evt.info.code);
					}
				});
			mytrace("connecting...");
			con.connect(serverAddress);
		}
		
		//callback function. Server call this if server close connection.
		public function close() : void {
			mytrace("closed from server");
		}
		
		private function onConnectSuccess(serverAddress:String) : void {
			mytrace("connected to server:" + serverAddress );
			startPublish();
		}
		
		private function startPublish(): void {
			stream = new NetStream(con);
			stream.attachAudio(mic);
			stream.bufferTime = 0;
			mytrace("audio codec : " + stream.audioCodec);
			stream.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					mytrace("netstream event:" + evt.info.code);
				});
					
			stream.publish("audio_1","record");
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			volumeMeter = new TextField();
			volumeMeter.autoSize = TextFieldAutoSize.LEFT;
			addChild(volumeMeter);
			//trace all microhone infos.
			mytrace("---------------------------");
			mytrace("Here are " +  Microphone.names.length.toString() + " mic(s) found ");
			for each(var micName: String in Microphone.names) {
				mytrace("   -" + micName);
			}
			mytrace("---------------------------");
			
			// get mic
			mic = Microphone.getMicrophone();
			if (mic == null) {
				mytrace("no mic");
				return;
			}else {
				//mic.setSilenceLevel(100, 1000);
				mytrace("mic obtained(" + mic.name + ")"); 
				mic.setUseEchoSuppression(true);
				mic.setLoopBack(true);
				//mic.codec = "Speex";
				mic.soundTransform = new SoundTransform(0);
				mic.framesPerPacket = 0;
				mic.rate = 44;
				mic.gain = 80;
				mic.setSilenceLevel(0, -1);
			}
			//enable loopback to local speaker (with volume zero);
			mic.addEventListener(StatusEvent.STATUS, 
				function(evt:StatusEvent):void {
					if (evt.code == "Microphone.Unmuted") {
						mytrace("[evt:Mic Unmuted]");
					} else {	//camera muted!
						mytrace("[evt:Mic Muted]");
					}
				});
			mic.addEventListener(ActivityEvent.ACTIVITY,
				function(evt:ActivityEvent) : void {
					if (mic.activityLevel != -1) {
						mytrace("detect mic activity:" +evt.activating);
						//connectToServer();
					}
				});
			//Security.showSettings(SecurityPanel.PRIVACY);
			
			
			//showSettings しない場合は何故かこのタイミングでセキュリティ設定ダイアログが出る。
			mic.setLoopBack(false);
			//Security.showSettings(SecurityPanel.PRIVACY);
		
			connectToServer();
			
			//watch audio level from mic
			var timer:Timer = new Timer(50);
			
			var timeLimit:int = 30000;
			var current:int = 0;
			timer.addEventListener(TimerEvent.TIMER,
				function(evt:TimerEvent):void {
					if (!mic.muted){
						volumeMeter.text = "timer event:mic=" + mic.activityLevel.toString();
						volumeMeter.text  = volumeMeter.text + "(volume):" + mic.soundTransform.volume.toString();
					}else {
						volumeMeter.text = "mic muted";
					}
					
					current = current + 50;
					if ( current >= timeLimit) {
						
						if (stream) {
							mytrace("now to close!");
							stream.close();
							stream.attachAudio(null);
							stream = null;
						}
					}
				});
			timer.start();
		}
		
	}
	
}