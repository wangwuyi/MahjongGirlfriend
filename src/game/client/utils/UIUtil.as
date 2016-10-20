package game.client.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.ColorMatrixFilter;
	
	import game.core.utils.Utils;

	public class UIUtil
	{
		
		public static var BLACK_FILTER:Array = [new ColorMatrixFilter([.5,0,0,0,0,0,.5,0,0,0,0,0,.5,0,0,0,0,0,1,0])]; //黑色遮盖效果
		
		public static function showWindow(target:DisplayObject, parent:DisplayObjectContainer = null, isCenter:Boolean = true):void
		{
			if (target != null && parent != null)
			{
				parent.addChild(target);
				if (isCenter == true)
				{
					centerUI(target);
				}
			}
		}
		
		public static function closeWindow(target:DisplayObject):void
		{
			if (target != null && target.parent != null)
			{
				target.parent.removeChild(target);
			}
		}
		
		public static function centerUI(target:DisplayObject):void
		{
			if (target != null && target.parent != null)
			{
				target.x = (target.parent.width - target.width) >> 2
				target.y = (target.parent.height - target.height) >> 2
			}
		}
		
		public static function shiftToTop(target:DisplayObject):void
		{
			if (target != null && target.parent != null)
			{
				var parent:DisplayObjectContainer = target.parent;
				if (parent.getChildIndex(target) < parent.numChildren - 1)
				{
					parent.setChildIndex(target, parent.numChildren - 1);
				}
			}
		}
		
		public static function removeAllChildren(container:DisplayObjectContainer):void
		{
			if(container == null)return;
			var len:int = container.numChildren;
			var index:int = 0;
			while(index < len)
			{
				container.removeChildAt(0);
				index++;
			}
		}
	}
}