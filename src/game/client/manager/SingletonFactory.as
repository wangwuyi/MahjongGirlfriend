package game.client.manager
{
	import game.client.utils.HashMap;
	

	public class SingletonFactory
	{
		private static var cache:HashMap = new HashMap();

		public static function createObject(clz:Class):*
		{
			var result:Object=cache.get(clz);
			if (result == null)
			{
				result = new clz();
				cache.put(clz, result);
			}
			return result;
		}

		public static function destroyObject(clz:Class):void
		{
			if (cache.containsKey(clz))
			{
				cache.remove(clz);
			}
		}

		/**
		 *消除所有单例
		 *
		 */
		public static function destroy():void
		{
			cache.clear();
		}
	}
}