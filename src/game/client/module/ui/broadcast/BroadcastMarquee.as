package game.client.module.ui.broadcast
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import game.client.model.GlobalModel;
	import game.client.utils.HtmlUtil;
	import game.component.BitmapDataCache;
	import game.component.Component;
	import game.component.Image;
	import game.component.Label;
	import game.core.utils.Timer;
	
	public class BroadcastMarquee extends Sprite
	{
		private static const BG_BITMAP_NAME:String = "systemNotice";
		private static const BG_WIDTH:int = 700;
		private static const BG_HEIGHT:int = 26;
		private static const MAX_LEN:int = 10;
		//间隔时间25毫秒，每次移动1像素
		private static const INTERVAL_TIME:int = 25;
		private static const INTERVAL_WIDTH:int = 1;
		
		private static var _instance:BroadcastMarquee;
		private static var _moveWidth:int = 0;
		
		private var _showText:Label;
		private var _list:Vector.<String>;
		private var _isStart:Boolean = false;
		private var _bgBitmap:Bitmap;
		
		public function BroadcastMarquee()
		{
			super();
			_bgBitmap = new Bitmap(new BitmapData(BG_WIDTH,BG_HEIGHT,true,0x55000000));
			_bgBitmap.y = 6;
			addChild(_bgBitmap);
			
			_showText = new Label();
			_showText.width = BG_WIDTH;
			_showText.y = 10;
			_showText.scrollRect = new Rectangle(-BG_WIDTH,0,BG_WIDTH,BG_HEIGHT);
			addChild(_showText);
			_list = new Vector.<String>();
			addEventListener(Event.ADDED_TO_STAGE,onAddedStage);
			mouseEnabled = false;
		}
		
		private static function getInstance():BroadcastMarquee
		{
			if(_instance == null)
			{
				_instance = new BroadcastMarquee();
			}
			return _instance;
		}
		
		private function addMsg(message:String,color:String,size:int):void
		{
			var content:String = HtmlUtil.font(message,color,size,false);
			var len:int = _list.length;
			if(len >= MAX_LEN)
			{
				_list.pop();
			}
			_list.push(content);
			if(_isStart == false)
			{
				GlobalModel.stage.addChild(this);
				onResize(null);
				marqueeStart();
			}
		}
		
		
		public static function show(message:String,color:String = "#FF0000",size:int = 14):void
		{
			getInstance().addMsg(message,color,size);
		}
		
		private function marqueeStart():void
		{
			_isStart = true;
			if(Timer.has(run) == false)
			{
				Timer.add(run);
			}
		}
		
		private var _lastTime:int = 0;
		private function run(now:int):void
		{
			var len:int = _list.length;
			if(now - _lastTime < INTERVAL_TIME || (len <= 0))
			{
				return;
			}
			_lastTime = now;
			_showText.htmlText = _list[0];
			var rect:Rectangle = _showText.scrollRect;
			rect.x += INTERVAL_WIDTH;
			_moveWidth += INTERVAL_WIDTH;
			_showText.scrollRect = rect;
			checkThreshold(_moveWidth);
		}
		
		private function checkThreshold(curMoveWidth:int):void
		{
			var moveWidth:int = curMoveWidth;
			var rect:Rectangle = _showText.scrollRect;
			if(_moveWidth >= BG_WIDTH + _showText.textWidth)
			{
				_list.shift();
				if(_list.length <= 0)
				{
					marqueeStop();
				}
				_moveWidth = 0;
				rect.x = -BG_WIDTH;
				_showText.scrollRect = rect;
			}
		}
		
		private function marqueeStop():void
		{
			_isStart = false;
			_lastTime = 0;
			if(Timer.has(run) == true)
			{
				Timer.remove(run);
			}
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		
		private function onAddedStage(e:Event):void
		{
			GlobalModel.stage.addEventListener(Event.RESIZE,onResize);
		}
		
		private function onResize(e:Event):void
		{
			this.x = (GlobalModel.stage.stageWidth - this.width) >> 1;
		}
		
	}
}