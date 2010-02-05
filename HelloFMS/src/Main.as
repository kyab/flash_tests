package 
{
	import flash.accessibility.Accessibility;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TextEvent;
	import flash.net.NetConnection;
	import flash.events.SecurityErrorEvent;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import LogTextField;
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class Main extends Sprite 
	{
		private var con : NetConnection;
		private var text: TextField;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initUI();
			connectToServer();			
			var button:SimpleButton = new SimpleButton;
			button.width = 100;
			button.height = 200;
			
			addChild(button);
			
		}	
		
		//client side function. called by server app
		public function HelloFromServer(): void {
			trace("Client:HelloFromServer() called");
		}
		
		//サーバにりじぇくとされたときに呼び出されるようなので、実装しておく。
		public function close() : void {
			trace("Server call close()");
		}
		
		//UI周りの初期化
		private function initUI() : void {
			text = new TextField;
			{
				var format : TextFormat = new TextFormat;
				format.size = 20;
				text.defaultTextFormat = format;
			}
			
			text.text = "connecting...";
			addChild(text);
			text.x = 100;
			text.y = 200;
			
			text.addEventListener(MouseEvent.CLICK,
				function(evt:MouseEvent) : void {
					text.text = "clicked";
					trace("mouse clicked");
				});
		}
		
		//サーバにNetConnectionクラスを使って接続してみる。
		private function connectToServer() : void {
			var serverAddress : String = "rtmp://koji-1/Hello";
			
			trace("connectToServer target = " + serverAddress);
			con = new NetConnection;
			con.client = this;
			con.addEventListener(NetStatusEvent.NET_STATUS,
				function(evt:NetStatusEvent) : void {
					switch(evt.info.code) {
					case "NetConnection.Connect.Success":
						trace("Success to connect Server");
						text.text = "connected";
						onConnectSuccess();
						break;
					case "NetConnection.Connect.Failed":
						trace("Failed to connect Server");
						break;
					case "NetConnection.Connect.Rejected":
						trace("Rejected from server");
						break;
					case "NetConnection.Connect.Closed":
						trace("Closed from server");
						break;
					default:
						trace(evt.info.code);
						break;
					}
				});
			con.connect(serverAddress);
		}
		
		private function onConnectSuccess():void {
			//stream...
		}
		

	}
	
}