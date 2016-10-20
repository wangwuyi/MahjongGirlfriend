package game.core.utils
{
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Timer
	{
		
		public static var tasks:Dictionary = new Dictionary();
		
		public static function add(fun:Function, time:int = 0):void
		{
			tasks[fun] = [fun, 0, time];
		}
		
		public static function run(e:Event):void
		{
			var now:int = getTimer();
			for each (var task:Array in tasks)
			{
				if ((now - task[1]) < task[2])
					continue;
				task[0](now);
				task[1] = now;
			}
		}
		
		public static function remove(fun:Function):void
		{
			delete tasks[fun];
		}
		
		public static function has(fun:Function):Boolean
		{
			return tasks[fun] ? true : false
		}
	}
}
