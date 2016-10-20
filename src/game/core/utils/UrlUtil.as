package game.core.utils
{
	import flash.utils.Dictionary;

	public class UrlUtil
	{
		public static const VER_TOKEN:String = "?v";
		
		private static var _data:Dictionary;
		
		/**
		 * 获取版本号
		 * @param url xxx.swf?v1
		 * @return 1
		 * 
		 */		
		public static function getVersionByUrl(url:String):int
		{
			var lastTokenIndex:int = url.lastIndexOf(VER_TOKEN);
			if(lastTokenIndex != -1)
			{
				return int(url.substring(lastTokenIndex + 2, url.length));
			}
			return 0;
		}
		
		/**
		 * 获取正规url
		 * @param url xxx.swf?v1
		 * @return xxx.swf
		 * 
		 */		
		public static function getOriginalUrl(url:String):String
		{
			var lastTokenIndex:int = url.lastIndexOf(VER_TOKEN);
			return url.substring(0, lastTokenIndex);
		}
	}
}