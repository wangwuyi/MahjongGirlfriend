package game.client.module.ui.broadcast
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.client.model.GlobalModel;
	import game.core.utils.Timer;

	public class Alert
	{
		private static var alertDic:Dictionary = new Dictionary;
		private var viewerVec:Vector.<Text>;
		private var dieVec:Vector.<Text>;
		
		public static const UP:int = 1;
		public static const CENTER:int = 2;
		public static const DOWN:int = 3;
		public static const RIGHT_DOWN:int = 4;
		public static const UI:int =5;
		
		private static const MAX_NUMBER:int = 4;//数量
		private static const UPDATEDELAY:int = 30; //更新间隔
		private static const DIEDELAY:int = 3500; //默认死亡时间
		private static const OUTTIME:int = 2000; //死亡淡出时间
		private static const OFFSET:int = 20; //几个文字定位的Y轴间隔
		private static const POSY:int = 28; //出生的偏移
		private var outSpeed:Number = 6; //淡出时Y轴速度
		private var outAlpha:Number = 0.02; //淡出A时LPHA淡出速度
		private var lastUpdateTime:int = 0; //上次更新
		
		public var isCanDispose:Boolean = true;
		public var key:Object;
		private static var pool:Vector.<Alert> = new Vector.<Alert>();
		public static function getInstance():Alert
		{
			return pool.length ? pool.shift() : new Alert();
		}
		
		public function Alert()
		{
			viewerVec = new Vector.<Text>;
			dieVec = new Vector.<Text>;
			outSpeed = 2;
			outAlpha = 0.05;
		}
		
		public static function show(message:String,pos:int = UP,container:DisplayObjectContainer = null):void
		{
			var alert:Alert = container == null? alertDic[pos]:alertDic[container];
			if(alert == null)
			{
				alert = Alert.getInstance();
				if(container == null)
				{
					alertDic[pos] = alert;
					alert.isCanDispose = false;
				}
				else
				{
					alertDic[container] = alert;
					alert.key = container;
				}
			}
			var text:Text = alert.addMsg(message);
			if(container == null)
			{
				text.x = (GlobalModel.stage.stageWidth - text.textWidth)/2;
				if(pos == UP)
				{
					text.offectY = 150;
				}
				else if(pos == CENTER)
				{
					text.offectY = GlobalModel.stage.stageHeight / 2 + 30;
				}
				else if(pos == DOWN)
				{
					text.offectY = GlobalModel.stage.stageHeight - 150;
				}
				else if(pos == RIGHT_DOWN)
				{
					text.x = GlobalModel.stage.stageWidth/6 + (GlobalModel.stage.stageWidth - text.textWidth)/2;
					text.offectY = GlobalModel.stage.stageHeight/2 + 100;
				}
				GlobalModel.stage.addChild(text);
			}
			else
			{
				text.x = (container.width - text.textWidth) / 2;
				text.offectY = container.height * 3/4;
				container.addChild(text);
			}
			text.y = POSY;
			
		}
		
		private function addMsg(message:String):Text
		{
			var text:Text = Text.getInstance();
			text.updateTime = getTimer();
			text.htmlText = message;
			text.width = text.textWidth + 5;
			viewerVec.unshift(text);
			start();
			return text;
		}
		
		private function run(now:int):void
		{
			var text:Text;
			//超出特定数量时，将前面强制淡出
			if(viewerVec.length > MAX_NUMBER)
			{
				for(var i:int = viewerVec.length - 1; i >= MAX_NUMBER; i--)
				{
					viewerVec[i].updateTime = now;
					dieVec.push(viewerVec[i]);
					viewerVec.splice(i, 1);
				}
			}
			//计时器到期,更新位置
			if(now - lastUpdateTime >= UPDATEDELAY) 
			{
				lastUpdateTime = now;
				for(var index:int = viewerVec.length - 1; index >= 0; index--) 
				{
					if(now - viewerVec[index].updateTime >= DIEDELAY) 
					{
						viewerVec[index].updateTime = now;
						dieVec.push(viewerVec[index]);
						viewerVec.splice(index, 1);
						continue;
					}
					text = viewerVec[index];
					var dis:Number = -OFFSET * index - POSY;
					if(text.y <= dis) 
					{
						continue;
					} 
					else 
					{
						var temp:Number = dis - text.y;
						var speed:Number = int(temp / 10) + 1;
						text.y += speed;
					}
				}
				for each(text in dieVec) 
				{
					text.alpha -= outAlpha;
					text.y -= outSpeed;
					if(text.alpha <= 0) 
					{
						dieVec.splice(dieVec.indexOf(text), 1);
						if(text.parent)
						{
							text.parent.removeChild(text);
						}
						text.dispose();
					}
				}
				if(viewerVec.length == 0 && dieVec.length == 0) 
				{
					stop();
				}
			}
		}
		
		public function start():void
		{
			Timer.add(run);
		}
		public function stop():void 
		{
			Timer.remove(run);
			if(isCanDispose == true)
			{
				dispose();
			}
		}
		
		public function dispose():void
		{
			pool.push(this);
			delete alertDic[key];
		}
	}
}
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class Text extends TextField
{
	
	private static const FILTER_BLACK:Array = [new GlowFilter(0x000000, 1, 2, 2, 15)];
	
	public var updateTime:int;
	private var _offectY:int;
	
	private static var pool:Vector.<Text> = new Vector.<Text>();
	
	public static function getInstance():Text
	{
		return pool.length ? pool.shift() : new Text();
	}
	
	public function Text()
	{
		var textFormat:TextFormat = new TextFormat;
		textFormat.align = TextFormatAlign.CENTER;
		textFormat.bold = false;
		textFormat.font = "SimSun";
		textFormat.color = 0xFFFF00;
		textFormat.italic = false;
		textFormat.leading = 0;
		textFormat.bold = false;
		textFormat.size = 14;
		textFormat.underline = false;
		textFormat.letterSpacing = 0;
		defaultTextFormat = textFormat;
		this.wordWrap = false;
		this.mouseEnabled = false;
		this.filters = FILTER_BLACK;
	}
	
	public function set offectY(value:int):void
	{
		_offectY = value;
	}
	
	public function get offectY():int
	{
		return _offectY;
	}
	
	override public function get y():Number
	{
		return super.y - offectY;
	}
	
	override public function set y(value:Number):void
	{
		super.y = value + offectY;
	}
	
	public function dispose():void
	{
		updateTime = 0;
		alpha = 1;
		pool.push(this);
	}
}