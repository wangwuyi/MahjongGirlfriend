package game.core.utils
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Tween
	{
		private static var pool:Array = [];
		private static var list:Array = [];
		private static const sprite:Sprite = new Sprite;
		
		public static function to(target:Object, time:int, propertie:Object, complete:Function = null, completeparams:Object = null, progress:Function = null, progressparams:Object = null):void
		{
			var thread:Thread;
			thread = pool.length > 0 ? pool.pop() : new Thread();
			thread.target = target;
			list.push(thread);
			thread.beginTime = getTimer();
			thread.totleTime = time;
			thread.propertie = [];
			for (var key:String in propertie)
			{
				thread.propertie.push([key, propertie[key][0], propertie[key][1]]);
			}
			thread.complete = complete;
			thread.completeparams = completeparams as Array;
			thread.progress = progress;
			thread.progressparams = progressparams as Array;
			start();
		}
		
		public static function stop(target:DisplayObject):void
		{
			var thread:Thread;
			var len:int = list.length;
			for (var i:int = len - 1; i >= 0; i--)
			{
				thread = list[i] as Thread;
				if (thread.target == target)
				{
					pool.push(thread);
					list.splice(i, 1);
					return;
				}
			}
		}
		
		private static function start():void
		{
			if (sprite.hasEventListener(Event.ENTER_FRAME) == false)
			{
				sprite.addEventListener(Event.ENTER_FRAME, run);
			}
		}
		
		private static function run(e:Event):void
		{
			if (list.length == 0)
			{
				sprite.removeEventListener(Event.ENTER_FRAME, run);
			}
			var now:int = getTimer();
			for (var i:int = list.length - 1; i >= 0; i--)
			{
				var thread:Thread = list[i];
				for (var j:int = 0; j < thread.propertie.length; j++)
				{
					var rate:Number = (now - thread.beginTime) / thread.totleTime;
					var value:Number = thread.propertie[j][1] + rate * (thread.propertie[j][2] - thread.propertie[j][1]);
					thread.target[thread.propertie[j][0]] = thread.propertie[j][2] > thread.propertie[j][1] ? (value > thread.propertie[j][2] ? thread.propertie[j][2] : value) : (value < thread.propertie[j][2] ? thread.propertie[j][2] : value);
					if (thread.progress != null)
					{
						thread.progress.apply(null,thread.progressparams);
					}
				}
				if ((now - thread.beginTime) > thread.totleTime)
				{
					if (thread.complete != null)
					{
						thread.complete.apply(null,thread.completeparams);
					}
					thread.dispose();
					list.splice(i, 1);
					pool.push(thread);
				}
			}
		}
	}
}

import flash.display.DisplayObject;

class Thread
{
	
	public var target:Object;
	public var beginTime:int;
	public var totleTime:int;
	public var propertie:Array;
	public var complete:Function;
	public var completeparams:Array;
	public var progress:Function;
	public var progressparams:Array;
	
	public function dispose():void
	{
		target = null;
		propertie = [];
		complete = null;
		completeparams = [];
		progress = null;
		progressparams = [];
	}
}
