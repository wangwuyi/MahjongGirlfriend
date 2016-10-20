package game.client.manager
{

	import flash.events.EventDispatcher;

	public class DispatchManager extends EventDispatcher
	{

		private static var _dispatch:DispatchManager;

		public function DispatchManager()
		{

		}

		public static function get instance():DispatchManager
		{
			if (_dispatch == null)
			{
				_dispatch=new DispatchManager();
			}
			return _dispatch;
		}

		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * 监听器添加函数添加参数
		 */
		public static function create(f:Function, ... arg):Function
		{
			var F:Boolean = false;
			var _f:Function = function(e:*, ... _arg):void
			{
				_arg = arg
				if (!F)
				{
					F=true
					_arg.unshift(e)
				}
				f.apply(null, _arg)
			};
			return _f;
		}
		
		public static function call(f:Function, ... args):Function
		{
			var _f:Function = function(... _arg):void
			{
				_arg = args;
				f.apply(null, _arg)
			};
			return _f;
		}

		public static function toString():String
		{
			return "Class DispatchManager";
		}

		/**
		 * 移除所有的监听事件
		 * */
		public function removeAllEventListener():void
		{
			_dispatch=null;
		}
	}
}