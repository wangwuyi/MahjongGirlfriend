package game.client.utils
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	public class FilterUtil
	{
		
		/**
		 * 灰白滤镜 
		 */		
		public static var BWFilter:Array =[new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
		/**
		 * 整体发亮滤镜 
		 */		
		public static var ShineFilter:Array = [new ColorMatrixFilter([1.5,0,0,0,0,0,1.5,0,0,0,0,0,1.5,0,0,0,0,0,1,0])];
		/**
		 *发光滤镜 
		 */		
		public static var glowFilter:Array = [new GlowFilter(0xFFB901)];
		/**
		 *黑边滤镜 
		 */		
		public static var blackFilter:Array = [new GlowFilter(0x0,1,2,2,10)];
		/**
		 * 灰掉
		 */
		public static function grayFilter(target:DisplayObject):void
		{
			if (target == null)
			{
				return;
			}
			var mat:Array=[0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0];
			var colorMat:ColorMatrixFilter=new ColorMatrixFilter(mat);
			target.filters=[colorMat];
		}

	}
}