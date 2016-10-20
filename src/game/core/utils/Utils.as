package game.core.utils
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import game.client.manager.StageManager;
	
	public class Utils
	{
		public static const LOG_NONE:int = 3;
		public static const LOG_ERR:int = 2;
		public static const LOG_INFO:int = 1;
		public static const LOG_ALL:int = 0;
		
		private static var _logLevel:int = 0;
		
		public static var RIGHT_DOWN:int		= 3;
		public static var RIGHT_UP:int			= 1;
		public static var LEFT_DOWN:int			= 5;
		public static var LEFT_UP:int			= 7;
		public static var LEFT:int				= 6;
		public static var RIGHT:int				= 2;
		public static var DOWN:int				= 4;
		public static var UP:int				= 0;
		
		public static function getWay(x0:int, y0:int, x:int, y:int):int
		{
			var a:Number = Math.atan2(y - y0, x - x0);
			var d:int = ((a + Math.PI * 3.625) % (Math.PI * 2)) / (Math.PI / 4);
			return d;
		}
		
		public static function dist(x1:int, y1:int, x2:int, y2:int):int
		{
			return int(Math.sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1)));
		}
		
		public static var rect:Rectangle = new Rectangle();
		public static var point:Point = new Point();
		
		/**
		 * 指定点下返回对象的数组，并且是obj的子项（或孙子项，依此类推）。 
		 * @param obj
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		public static function getObjectsUnderPoint(obj:DisplayObjectContainer, x:int, y:int):Array
		{
			point.x = x;
			point.y = y;
			return obj.getObjectsUnderPoint(point);
		}
		
		/**
		 * 将 point对象从显示对象的（本地）坐标转换为舞台（全局）坐标。
		 * @param obj
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		public static function localToGlobal(obj:DisplayObject, x:int, y:int):Point
		{
			point.x = x;
			point.y = y;
			return obj.localToGlobal(point);
		}
		
		private static var date:Date = new Date();
		
		public static function toTimeString(time:Number):String
		{
			date.time = time
			var result:String = "";
			if (date.hoursUTC)
				result += (date.hoursUTC + "小时");
			if (date.minutesUTC)
				result += (date.minutesUTC + "分");
			if (date.secondsUTC)
				result += (date.secondsUTC + "秒");
			return result;
		}
		
		/**
		 * yyyy-MM-dd hh:mm:ss 
		 * @param time
		 * @return 
		 * 
		 */		
		public static function toDetailDateString(time:Number):String
		{
			date.time = time
			return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
		}
		
		/**
		 * X年X月X日 
		 * @param time
		 * @return 
		 * 
		 */		
		public static function toDayDataString(time:Number):String
		{
			date.time = time
			return date.getFullYear() + "年" + (date.getMonth() + 1) + "月" + date.getDate() + "日";
		}
		
		/**
		 * 秒数转换成字符串 00:00:00
		 * @param second
		 * @return 
		 * 
		 */		
		public static function toTime(second:int):String
		{
			var h:String = uint(second / 3600).toString()
			var m:String = uint(second % 3600 / 60).toString()
			var s:String = uint(second % 3600 % 60).toString()
			h = h.length == 1 ? "0" + h : h;
			m = m.length == 1 ? "0" + m : m;
			s = s.length == 1 ? "0" + s : s;
			return h + ":" + m + ":" + s;
		}
		
		private static const DISABLE_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.3, 0.6, 0.08, 0, -50, 0.3, 0.6, 0.08, 0, -50, 0.3, 0.6, 0.08, 0, -50, 0, 0, 0, 1, 0]);
		private static const DISABLE_FILTERS:Array = [DISABLE_FILTER];
		
		/**
		 * 对象灰掉 
		 * @param target
		 * @param value
		 * 
		 */		
		public static function setDisable(target:DisplayObject, value:Boolean = true):void
		{
			var filters:Array = target.filters
			var index:int = indexOfDisableFilter(filters);
			if (value)
			{
				if (!filters || !filters.length)
					filters = DISABLE_FILTERS;
				else if (index == -1)
					filters.push(DISABLE_FILTER);
			}
			else if (filters && index != -1)
				filters.splice(index, 1);
			target.filters = filters;
		}
		
		private static function indexOfDisableFilter(filters:Array):int
		{
			for (var i:int = 0; i < filters.length; i++)
				if (filters[i] is ColorMatrixFilter)
					return i;
			return -1;
		}
		
		public static function log(msg:String, level:int = 1):void
		{
			if (level >= _logLevel)
			{
				var logStr:String = date.toTimeString() + " " + getTimer() + " " + msg;
				StageManager.stageText.appendText(logStr + "\n");
				StageManager.stageText.scrollV = StageManager.stageText.maxScrollV;
				trace(logStr);
			}
		}
		
		public static function set logLevel(value:int):void
		{
			_logLevel = value;
		}
		
		public static function get logLevel():int
		{
			return _logLevel;
		}
		
		public static function clearStageText():void
		{
			StageManager.stageText.text = "";
		}
		
		public static function getDisplayName(value:String):String
		{
			var slices:Array = value.split("]");
			var displayName:String = slices[0] ? slices[1] : "";
			return displayName;
		}
		
		public static function createTransparentHotArea(width:int, height:int):Sprite
		{
			var result:Sprite = new Sprite();
			var g:Graphics = result.graphics;
			g.beginFill(0xffffff, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			return result;
		}
		
		/**
		 * x_way获取跟随x位置 
		 * @return 
		 * 
		 */		
		public static function getXByWay(x:Number,way:int,multiple:int=1):Number{
			if(way>UP&&way<DOWN){
				return x - (60*multiple);
			}else if(way>DOWN){
				return x + (60*multiple);
			}
			return x;
		}
		
		/**
		 * y_way获取跟随y位置 
		 * @return 
		 * 
		 */	
		public static function getYByWay(y:Number,way:int,multiple:int=1):Number{
			if(way==UP||way==RIGHT_UP||way==LEFT_UP){
				return y + (40*multiple);
			}else if(way==RIGHT_DOWN||way==DOWN||way==LEFT_DOWN){
				return y - (40*multiple);
			}
			return y;
		}
	
	}
}
