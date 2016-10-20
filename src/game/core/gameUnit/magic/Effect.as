package game.core.gameUnit.magic
{
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import game.core.manager.ResourceManager;
	import game.core.utils.Timer;
	
	public class Effect extends Bitmap
	{
		public static const EVT_END:String = "end";
		
		public static const POS_DOWN:int = 0;
		public static const POS_MIDDLE:int = 1;
		public static const POS_UP:int = 2;
		
		public static const ROLE_DIE:int = 20000;
		
		private static var list:Vector.<Effect> = new Vector.<Effect>();
		
		public var sourceID:int;
		private var isLoop:Boolean;
		private var displayData:Object;
		private var totalTime:int;
		private var beginTime:int;
		private var lastTime:int;
		private var initTime:int;
		private var rate:Number;
		private var _url:String;
		private var isInitConfig:Boolean = false;
		
		public var px:int, py:int;
		public var block:Boolean = false;
		
		public static var pool:Array = [];
		
		/**
		 * block为true时每次生成一个新对象
		 * @param block
		 * @return 
		 * 
		 */		
		public static function getEffect(block:Boolean = false):Effect
		{
			if(block == false)
			{
				if(pool.length > 0)
				{
					return pool.pop();
				}
				return new Effect(false);
			}
			return new Effect(true);
		}
		
		public function Effect(block:Boolean)
		{
			this.block = block;
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		public function init(sourceID:int, loop:Boolean = false, totalTime:int = 0, beginTime:int = 0, lastTime:int = 0):void
		{
			url = "assets/resource/magic/" + sourceID;
			isLoop = loop;
			this.sourceID = sourceID;
			this.totalTime = totalTime;
			this.beginTime = beginTime;
			this.lastTime = lastTime;
			removeFromParent();
		}

		private function onAddToStage(e:Event):void
		{
			if (!beginTime)
			{
				beginTime = getTimer();
			}
			if (!Timer.has(run))
			{
				Timer.add(run);
			}
			initTime = getTimer();
			list.push(this);
		}

		private function onRemoveFromStage(e:Event):void
		{
			lastTime = 0;
			px = 0;
			py = 0;
			var index:int = list.indexOf(this);
			if(index > -1)
			{
				list.splice(index, 1);
			}
		}
		
		private function removeFromParent():void
		{
			if(this.parent != null)
			{
				this.parent.removeChild(this);
			}
		}
		
		public static function run(now:int):void
		{
			for each (var effect:Effect in list)
			{
				if (!effect.url)
				{
					effect.dispose();
					continue;
				}
				if (!effect.isInitConfig)
				{
					var totalTimeObj:Object = ResourceManager.getConfig(effect.url, "normal", "totalTime");
					if(totalTimeObj != null && effect.totalTime == 0)
					{
						effect.isInitConfig = true;
						effect.totalTime = int(totalTimeObj);
					}
					var blendModeObj:Object = ResourceManager.getConfig(effect.url, "normal", "blendMode");
					if(blendModeObj != null)
					{
						effect.totalTime = int(totalTimeObj);
					}
				}
				if (!effect.totalTime)
				{
					effect.dispose();
					effect.dispatchEvent(new Event(EVT_END));
					continue;
				}
				if (now + effect.lastTime - effect.beginTime >= effect.totalTime)
				{
					if (effect.isLoop)
					{
						effect.beginTime = now;
					}
					else
					{
						effect.dispose();
						effect.dispatchEvent(new Event(EVT_END));
					}
				}
				else
				{
					var rate:Number = (now + effect.lastTime - effect.beginTime) / effect.totalTime;
					if (rate < 0)
					{
						rate = 0;
					}
					var displayData:Object = ResourceManager.getResource(effect.url, "normal", 0, rate);
					if (displayData == null)
					{
						effect.beginTime = now;
						if(now - effect.initTime > 5*60*1000)
						{
							effect.dispose();
						}
						continue;
					}
					if (effect.bitmapData != displayData.bitmapData)
					{
						effect.bitmapData = displayData.bitmapData;
						effect.x = displayData.x + effect.px;
						effect.y = displayData.y + effect.py;
					}
				}
			}
		}
		
		public function set url(value:String):void
		{
			if(_url != value && _url != null && _url != "")
			{
				ResourceManager.decreaseResourceReference(_url);	
			}
			if(value != _url && value != "" && value != null)
			{
				ResourceManager.increaseResourceReference(value);
			}
			_url = value;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function dispose(force:Boolean = false):void
		{
			this.rotation = 0;
			bitmapData = null;
			totalTime = 0;
			blendMode = BlendMode.NORMAL;
			initTime = 0;
			isInitConfig = false;
			onRemoveFromStage(null);
			removeFromParent();
			if(force == true)
			{
				block = false;
			}
			if (block == false)
			{
				pool.push(this);
			}
			url = null;
		}
	}
}
