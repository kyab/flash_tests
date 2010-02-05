package 
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.text.*;
	import flash.net.*;
	import flash.events.SecurityErrorEvent;
	import LogTextField;
	
	
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	
	 /*prototype extention*/
	DisplayObject.prototype.addTo = function (container:DisplayObjectContainer ): DisplayObject {
		trace(this);
		return container.addChild(this);
	}
	 
	 public class Main extends Sprite 
	{
		private var logField:LogTextField = new LogTextField;
		
		private var con : NetConnection;
		private var stream : NetStream;
		private var video : Video;
		
		public function Main():void 
		{
			
			//logfield
			logField.autoSize = TextFieldAutoSize.LEFT;
			logField.setFormatWithSizeColor( 20, 0x223344);
			logField.y = 300;
			logField.addTo(this);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			

			//video.attach
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//var video :Video = new Video;
			con = new NetConnection;
			con.client = this;
			
			con.addEventListener(NetStatusEvent.NET_STATUS, 
				function(event:NetStatusEvent):void {
					trace(event.info.code);
				}
			);
			con.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
				function(event:SecurityErrorEvent):void {
					trace("security error");
				}
			);
			//con.connect("rtmp:/live");
			con.connect("rtmp://koji-1/live");
		}
		public function onBWDone() : void {
			trace("onBWDone");
			trace(arguments);
			
			stream = new NetStream(con);
			stream.bufferTime = 0;
			
			video = new Video();
			video.smoothing = true;
			video.addTo(this);
			video.attachNetStream(stream);
			
			stream.play("cameraFeed");
			
			trace("FPS:" + stream.currentFPS);
		}
		
	}
	
}