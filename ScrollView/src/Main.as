package 
{

	//DONE スクロールバー領域のクリックでスクロール
	//DONE マウスホイールのホイールでスクロール
	//TextField依存をやめたい(内部は単にDisplayObject)をcontentsに持つだけにしたい。
	
	//TODO stageにaddEventListenerするのをやめたい...。
	//  とりあえず、addEventListener()にてキャプチャ段階でListenし、その段階でdragging状態なら以降のイベント処理をさせないことにする。..とだめでした。（イベント認識しない）
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.*;
	import flash.utils.Timer;
	import mx.controls.Button;

	public class Main extends Sprite 
	{
		private var txt:TextField;
		private var scrollView:Sprite;
		private var scrollBarArea:Sprite;
		private var bar : Sprite;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//scroll view
			scrollView = new Sprite;
			
			scrollView.graphics.beginFill(0xEEEEEE);
			scrollView.graphics.drawRect(0, 0, 300, 400);
			scrollView.graphics.endFill();
			
			scrollView.width = 300;
			scrollView.height = 400;
			scrollView.x = 10;
			scrollView.y = 10;
			
			//scroll area (bar's background)
			scrollBarArea = new Sprite;
			scrollBarArea.graphics.beginFill(0xCCCCCC);
			scrollBarArea.graphics.drawRoundRect(0, 0, 20, scrollView.height, 10, 10);
			scrollBarArea.graphics.endFill();
			scrollBarArea.x = 280;
			scrollBarArea.y = 0;
			scrollView.addChild(scrollBarArea);
			
			//scrollbar
			bar = new Sprite();
			with (bar) {
				graphics.beginFill(0x2222FF); //blue
				graphics.drawRoundRect(0, 0, 20, 100, 10,10);
				graphics.endFill();	
			}
			bar.x = 0;
			bar.y = 0;
			scrollBarArea.addChild(bar);			
			this.addChild(scrollView);

		
			txt = new TextField();
			txt.text = "hoge --------------------\n";
			txt.multiline = true;
			txt.alwaysShowSelection = true;
			txt.border = true;
			//txt.opaqueBackground  = false;
			//txt.background = true;
			//txt.backgroundColor = 0xBBBBBB;
			txt.autoSize = TextFieldAutoSize.LEFT;	//This is required for auto virtical size

			txt.scrollRect = new Rectangle(0, 0,scrollView.width - bar.width, scrollView.height);	//ここで縦長にすると、scrollViewも縦に伸びてしまう。なんてこった。
			
			//このfor文での追加はscrollRect設定前にやってしまうと、txtの縦サイズを大きく変えてしまう。結果的にscrollViewまで縦に伸びてしまう。なんてこった。
			for (var i:int = 0; i < 10 ; i++) {
				//txt.appendText(i.toString() + ":" + "txt.height=" + txt.height.toString() + "txt.textHeight=" + txt.textHeight + "\n");
			}
			scrollView.addChild(txt);
			trace("txt.height:" + txt.height);
			var timer:Timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, function(evt:TimerEvent): void {
				resizeBar();		
			}); 
			timer.start();
			for (var i2:int = 1; i2 <100 ; i2++) {
				txt.appendText("::" +  i2.toString() + ":" + "txt.height=" + txt.height.toString() + "txt.textHeight=" + txt.textHeight + "\n");
			}
			txt.addEventListener(Event.CHANGE, function(evt:Event) : void {
				trace("txt changed");
			});
			
			var dragging:Boolean = false;
			var dragStartPosY:int = 0;
			bar.addEventListener(MouseEvent.MOUSE_DOWN, function(evt:MouseEvent):void {
				trace("drag started : mouseY = " + bar.mouseY.toString());
				dragging = true;
				dragStartPosY = bar.mouseY;
				
			});
			bar.addEventListener(MouseEvent.MOUSE_MOVE, function(evt:MouseEvent):void {

			});
			bar.addEventListener(MouseEvent.MOUSE_UP, function(evt:MouseEvent) : void {
				if (dragging) {
					dragging = false;
					trace("drag ended");
				}
			});
			bar.addEventListener(MouseEvent.MOUSE_OUT, function(evt:MouseEvent) : void {
				if (dragging) {
					trace("Mouse Leaved");
				}
			});
			
			scrollBarArea.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) : void {
				//if clicked on outside of bar, scroll bar height.
				if (scrollBarArea.mouseY < bar.y) {
					scrollTo(bar.y - (bar.height-10));
				}else if (scrollBarArea.mouseY > bar.y + bar.height) {
					scrollTo(bar.y + (bar.height-10));
				}
				
			}, false);
			
			//Mouse Wheel
			scrollView.addEventListener(MouseEvent.MOUSE_WHEEL, function(evt:MouseEvent) : void {
				var wheelRate : int = 1;
				scrollTo(bar.y - evt.delta * wheelRate);
				trace("Mouse Wheel, delta = " + evt.delta);
			});
			
			//listen for capture mode and cancel if dragging
			stage.addEventListener(MouseEvent.MOUSE_MOVE, function(evt:MouseEvent) : void {
				//trace("STAGE_MOUSE_MOVE: bar.y = " + bar.y);
				if (dragging) {
					trace("STAGE_MOUSE_MOVE: bar.y = " + bar.y);
					var posInVar: Point = bar.globalToLocal(new Point(stage.mouseX, stage.mouseY));
					var moveY:int = posInVar.y - dragStartPosY;
					if (bar.y + moveY < 0) {
						scrollToTop();
					}else if (bar.y + moveY + bar.height > scrollView.height) {
						scrollToBottom();
					}else {
						scrollTo(bar.y + moveY);
					}
					//trace("STAGE_MOUSE_MOCE: moveY = " + moveY + " y=" + bar.y);
					evt.stopPropagation();
				}
			},false);
			stage.addEventListener(MouseEvent.MOUSE_UP, function(evt:MouseEvent) : void {
				if (dragging) {
					dragging = false;
					trace("dragging ended\n");
					evt.stopPropagation();
				}
			},false);
			
			var btn : Sprite = new Sprite;
			with (btn) {
				graphics.beginFill(0x00FF00);
				graphics.drawRect(0, 0, 100, 100);
				graphics.endFill();
			}
			btn.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent) : void {
					txt.appendText("btn clicked.added\n");
					resizeBar();
					scrollToBottom();
				});
			addChild(btn);
			btn.x = 300 + 10;
		}
		private function scrollContents() : void {
			var rect_:Rectangle = txt.scrollRect;
			var newY:Number = bar.y / scrollView.height * (txt.textHeight + 10/*おまけ*/);
			rect_.y =  newY;
			txt.scrollRect = rect_;		
		}
		private function scrollToTop() : void {
			bar.y = 0;
			scrollContents();
		}
		private function scrollToBottom(): void {
			bar.y = scrollView.height - bar.height;
			scrollContents();
		}
		
		private function scrollTo(y:int) : void {
			if (y < 0) {
				scrollToTop();
			}else if ( (y + bar.height) > scrollView.height) {
				scrollToBottom();
			}else {
				bar.y = y;
				scrollContents();
			}
		}
		
		public function resizeBar() : void {
			
			//resize bar
			
			//for some reason, TextField::height does not indicate actual height of text field when scrollRect specified.
			//so use textHeight property.
			var percent:Number = scrollView.height / txt.textHeight;
			if (percent > 1) {
				bar.height = scrollView.height;
			}else {
				bar.height = int(scrollView.height * percent);
			}
			
			//redraw bar itself
			bar.graphics.beginFill(0x6666FF); //blue
			bar.graphics.drawRoundRect(0, 0, bar.width, bar.height, 10,10);
			bar.graphics.endFill();
		}
		
	}
	
}

import flash.display.Sprite;
class ScrollView extends Sprite {
	
	public function ScrollView() {
		;
	}
}


