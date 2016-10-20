package game.core.utils
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class NightEffect
	{
		private static var EFFECT_TIME:int = 5000;
		private static var colorTransform:ColorTransform = new ColorTransform;
		private static var mask:Shape;
		private static var isNight:Boolean;
		private static var old:uint;
		private static const OFFSET_R:int = 50;
		private static const OFFSET_G:int = 110;
		private static const OFFSET_B:int = -18;
		private static var list:Dictionary = new Dictionary;
		
		public static function set night(value:Boolean):void
		{
			if (value == isNight)
				return;
			old = getTimer();
			isNight = value;
			Timer.add(run);
			colorTransform.redOffset = -OFFSET_R
			colorTransform.greenOffset = -OFFSET_G
			colorTransform.blueOffset = -OFFSET_B
		}
		
		public static function get night():Boolean
		{
			return isNight
		}
		
		private static function run(now:uint):void
		{
			var time:int = now - old;
			var scale:Number = 1 - (EFFECT_TIME - time) / EFFECT_TIME;
			if (scale >= 1)
				scale = 1;
			if (night)
			{
				colorTransform.redOffset = -OFFSET_R * scale;
				colorTransform.greenOffset = -OFFSET_G * scale;
				colorTransform.blueOffset = -OFFSET_B * scale;
			}
			else
			{
				colorTransform.redOffset = -OFFSET_R + OFFSET_R * scale
				colorTransform.greenOffset = -OFFSET_G + OFFSET_G * scale
				colorTransform.blueOffset = -OFFSET_B + OFFSET_B * scale
			}
			var target:Object
			for each (target in list)
			{
				target.transform.colorTransform = colorTransform;
			}
			if (scale >= 1)
				Timer.remove(run);
		}
		
		public static function add(target:Object):void
		{
			list[target] = target
		}
		
		public static function remove(target:Object):void
		{
			delete list[target];
		}
	
	}
}
