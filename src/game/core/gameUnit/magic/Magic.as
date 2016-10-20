package game.core.gameUnit.magic
{
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.core.gameUnit.GameUnit;
	import game.core.gameUnit.role.Role;
	import game.core.utils.Timer;
	import game.core.utils.Tween;
	import game.core.utils.Utils;
	
	public class Magic extends GameUnit
	{
		private static const MAGIC_FLY_DISTANCE_THRESHOLD:int = 50;
		private static const MAGIC_INDEX_POS:int = 70000;
		private static var pool:Array = [];
		private static var index:int;
		private static var idDic:Dictionary = new Dictionary();
		
		private var effect:Effect;
		private var start_x:int, start_y:int;
		private var end_x:int, end_y:int;
		private var dx:int, dy:int;
		private var lastTime:int;
		private var allTime:int;
		
		private var _trackTarget:GameUnit;
		private var _offetX:int;
		private var _offetY:int;
		private var _endCallBack:Function;
		
		public function Magic()
		{
			mouseEnabled = false;
			mouseChildren = false;
			effect = Effect.getEffect(true);
			_offetY = 2;
		}
		
		public static function getInstance():Magic
		{
			var magic:Magic = pool.length ? pool.shift() : new Magic();
			return magic;
		}
		
		/**
		 * 初始效果effect
		 * @param _id
		 * @param effID
		 * @param totalTime
		 * @param isLoop		为true时，对isSelfRemove有影响
		 * @param isSelfRemove	为true时，特效播放结束后，自动清理掉，从父容器中移除
		 * @param endCallBack
		 * 
		 */		
		public function init(_id:int, effID:int, totalTime:int, isLoop:Boolean = false, isSelfRemove:Boolean = false, endCallBack:Function = null):void
		{
			id = _id || (MAGIC_INDEX_POS + (++index));
			if (idDic[id] != null)
			{
				Utils.log("Magic id 重复" + id, Utils.LOG_ERR);
			}
			idDic[id] = this;
			_endCallBack = endCallBack;
			effect.init(effID, isLoop, totalTime);
			if(isSelfRemove == true)
			{
				addEffectEventListener();
			}
			addChild(effect);
		}
		
		private function addEffectEventListener():void
		{
			effect.addEventListener(Effect.EVT_END, onEffectEnded);
		}
		
		public function removeEffectEventListener():void
		{
			if(effect.hasEventListener(Effect.EVT_END) == true)
			{
				effect.removeEventListener(Effect.EVT_END, onEffectEnded);
			}
		}
		
		private function onEffectEnded(evt:Event):void
		{
			effect.removeEventListener(Effect.EVT_END, onEffectEnded);
//			GameUnitManager.removeUnit(this);
		}
		
		public function go(target:Role):void
		{
			start_x = x;
			start_y = y;
			end_x = target.x;
			end_y = target.y - target.parts.body.height / 2;
			playGo();
		}
		
		public function goPos(posX:int,posY:int):void
		{
			start_x = x;
			start_y = y;
			end_x = posX;
			end_y = posY;
			playGo();
		}
		
		private function playGo():void
		{
			var len:int = Math.sqrt((end_y - start_y) * (end_y - start_y) + (end_x - start_x) * (end_x - start_x));
			if (len < MAGIC_FLY_DISTANCE_THRESHOLD)
			{
				dispose();
			}
			else
			{
				allTime = len / 800 * 1000;
				lastTime = getTimer();
				dx = end_x - start_x;
				dy = end_y - start_y;
				rotation = -Math.atan2((end_x - start_x), (end_y - start_y)) * 180 / Math.PI + 90;
				x = Math.round(dx + start_x);
				y = Math.round(dy + start_y);
//				GameUnitManager.addUnit(this);
				Timer.add(run);
				Tween.to(this, 100, {alpha: [0, 1]});
			}
		}
		
		private function run(now:int):void
		{
			var rate:Number = (now - lastTime) / allTime;
			if (rate > 0.9)
			{
				x = end_x;
				y = end_y;
				removeEffectEventListener();
//				GameUnitManager.removeUnit(this);
				return;
			}
			else
			{
				rotation = -Math.atan2((end_x - start_x), (end_y - start_y)) * 180 / Math.PI + 90;
				x = Math.round(rate * dx + start_x);
				y = Math.round(rate * dy + start_y);
			}
			algin();
		}
		
		public function set trackTarget(gameUnit:GameUnit):void
		{
			_trackTarget = gameUnit;
			Timer.add(track);
		}
		
		private function track(now:int):void
		{
			if(_trackTarget != null)
			{
				this.x = _trackTarget.x + _offetX;
				this.y = _trackTarget.y + _offetY;
				if(_trackTarget.parent == null)
				{
//					GameUnitManager.removeUnit(this);
				}
			}
		}
		
		public function setOffetPos(x:int,y:int):void
		{
			_offetX = x;
			_offetY = y;
		}

		public override function checkIn():void
		{
			if(_endCallBack != null)
			{
				_endCallBack();
			}
			Tween.stop(this);
			this.rotation = 0;
			super.checkIn();
		}
		
		public override function dispose():void
		{
			super.dispose();
			removeEffectEventListener();
			Timer.remove(run);
			_trackTarget = null;
			_endCallBack = null;
			Timer.remove(track);
			effect.dispose();
			pool.push(this);
			_offetY = 2;
			_offetX = 0;
			delete idDic[id];
		}
		
		public function disposeEffect():void{
			effect.dispose();
		}
	}
}
