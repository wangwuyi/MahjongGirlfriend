package game.core.utils
{
	import flash.utils.Dictionary;

	/**
	 * 资源预加载器
	 * @author 4399
	 * 
	 */	
	public class MassPreloader
	{
		private static var _queue:Array;
		private static var _recordDic:Dictionary;
		
		initialize();
		
		private static function initialize():void
		{
			_queue = new Array();
			_recordDic = new Dictionary();
		}
		
		public static function addResourceUrl(url:String):void
		{
			if(_recordDic[url] == null)
			{
				_queue.push(url);
				_recordDic[url] = true;
			}
		}
		
		public static function getResourceUrl():String
		{
			if(_queue.length > 0)
			{
				return _queue.shift();
			}
			return null;
		}
		
	}
}