package 
{
	//import fl.video.FLVPlayback;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.utils.Timer;

	
	/**
	 * ...
	 * @author K.Yoshioka
	 */

	public class Main extends Sprite 
	{
		private var micGauge:Sprite;
		private var micTxt:TextField;
		private var value:Shape;
		private var mic:Microphone;
		private var stream:NetStream;
		private var con : NetConnection;
		private var btn:MyButton;
		private var btnPlay: MyButton;
		private var recording:Boolean;
		
		//private var player:FLVPlayback;
		
		private var traceFrame:ScrollTextField;
		
		private function mytrace(message:String):void {
			if (!traceFrame) {
				traceFrame = new ScrollTextField(stage.stageWidth-200, stage.stageHeight);
				traceFrame.x = 200;
				//traceFrame.txtField.background = true;
				traceFrame.txtField.backgroundColor = 0xFF22FF;
				

				addChild(traceFrame);
			}
			var d : Date = new Date;
			var dateStr:String = 
					(d.hours > 10 ? d.hours : "0" + d.hours) + ":" +
					(d.minutes > 10 ? d.minutes: "0" + d.minutes) + ":" +
					(d.milliseconds > 100 ? d.milliseconds : 
							(d.milliseconds > 10 ? "0" + d.milliseconds :
								"00" + d.milliseconds));
			dateStr  = "[" + dateStr + "]:";

			trace(dateStr +  message);
			
			traceFrame.txtField.appendText(dateStr + message + "\n");
			traceFrame.scrollToBottom();
		}
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function connectToServer():void {
			var serverAddress : String = "rtmp://koji-1/AudioServer";
			
			con = new NetConnection();
			con.client = this;
			con.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					switch(evt.info.code) {
					case "NetConnection.Connect.Success":
						onConnectSuccess(serverAddress);
						break;
					default:
						mytrace("failed to connect server : " + serverAddress );
						mytrace("...error = " + evt.info.code);
					}
				});
			mytrace("connectiong....");
			con.connect(serverAddress);
			
		}
		public function onConnectSuccess(serverAddress:String) : void {
			mytrace("connectiong....connected:" + serverAddress);
		}
		
		//called by server(automatically?)
		public function close() : void {
			mytrace("closed from server");
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			mytrace("started. stageSize = " + stage.stageWidth + "," + stage.stageHeight);
			btn = new MyButton(100, 30, "record");
			btn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void {
				mytrace("clicked");
				//btn.setText("clicked");
				onClick();
			});
			btn.x = 10;
			btn.y = 50;
			addChild(btn);
			
			btnPlay = new MyButton(100, 30, "play");
			btnPlay.addEventListener(MouseEvent.CLICK, onPlay);
			btnPlay.x = 10;
			btnPlay.y = 90;
			addChild(btnPlay);
			
			micGauge = new Sprite;
			micGauge.graphics.beginFill(0x000000);
			micGauge.graphics.drawRect(0, 0, 100, 20);
			micGauge.graphics.endFill();
			micGauge.x = 10;
			micGauge.y = 10;
			value = new Shape;
			value.graphics.beginFill(0xEEEEEE);
			value.graphics.drawRect(0, 0, 50, 20);
			value.graphics.endFill();
			
			micTxt = new TextField;
			micTxt.text = "none";
			micTxt.x = 110;
			micGauge.addChild(micTxt);
			micGauge.addChild(value);
			addChild(micGauge);


			mic = Microphone.getMicrophone();
			if (mic == null) {
				mytrace("[error:no camera]");
				return;
			}
			mytrace("mic:" + mic.name);
			mic.setUseEchoSuppression(true);
			mic.setLoopBack(true);
			mic.soundTransform = new SoundTransform(0);
			mic.rate = 44;
			mic.gain = 50;
			mic.setSilenceLevel(0, -1);
			
			var timer:Timer = new Timer(10);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			
			recording = false;
			connectToServer();
		}
		
		private function onTimer(evt:TimerEvent) : void {
			if (mic) {
				if (!mic.muted) {
					value.graphics.clear();
					value.graphics.beginFill(0xFF0000);
					value.graphics.drawRect(0, 0, mic.activityLevel, 20);
					value.graphics.endFill();
					micTxt.text = mic.activityLevel.toString();
				}
			}
		}
		private function onClick() : void {
			if (recording) {
				btn.setText("record");
				stopPublish();
			}else {
				btn.setText("stop");
				startPublish();
			}
			recording = !recording;
		}
		
		private function startPublish():void {
			stream = new NetStream(con);
			stream.attachAudio(mic);
			stream.bufferTime = 0;
			stream.audioCodec
			stream.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					mytrace("netstream event:" + evt.info.code);
				});
			
			stream.publish("audio0", "record");
		}
		
		private function stopPublish():void {
			stream.close();
			stream.attachAudio(null);
			stream = null;
		}
		public function onMetaData(info:Object) : void {
			mytrace("onMetaData" + info.toString());
		}
		
		public function onPlayStatus(info:Object) : void {
			mytrace("onPlayStatus code =" + info.code);
			if (info.code == "NetStream.Play.Complete") {
				btnPlay.setText("play");
			}
			//mytrace(info.code.toString());
		}
		private function onPlay(evt:MouseEvent):void {
			if (btnPlay.getText() == "play"){
				stream = new NetStream(con);
				stream.client = this;
				stream.addEventListener(NetStatusEvent.NET_STATUS,
					function(evt:NetStatusEvent) : void {
						mytrace("netstream event:" + evt.info.code);
						
					});
				stream.play("audio0");
				stream.receiveVideo(false);
				btnPlay.setText("stop");
			}else {
				stream.pause();
				stream.seek(0);
				btnPlay.setText("play");
			}
		}
	}
	

}