package game.core.utils
{
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	public class ResourcePool
	{
		private static var sources:Dictionary = new Dictionary(true);
		
		public function ResourcePool()
		{
		}
		
		public static function add(url:String, applicationDomain:ApplicationDomain):void
		{
			sources[url] = applicationDomain;
		}
		
		public static function remove(url:String):*
		{
			var result:* = get(url);
			delete sources[url];
			return result;
		}
		
		public static function get(key:String):Object
		{
			return sources[key];
		}
		
		public static function getClass(key:String, property:String):Class
		{
			var cl:* = sources[key];
			if (cl && cl.hasDefinition(property))
			{
				return cl.getDefinition(property);
			}
			return null;
		}
		
		public static function dispose():void
		{
			sources = null;
			return;
		}
		
		public static function hasResource(key:String):Boolean
		{
			return sources[key] != null;
		}
	}
}