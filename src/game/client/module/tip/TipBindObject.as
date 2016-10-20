package game.client.module.tip
{
	import flash.display.DisplayObject;

	public class TipBindObject
	{
		/**
		 * tip目标 
		 */		
		public var target:DisplayObject;
		/**
		 * 是否显示关闭按钮 
		 */		
		public var isShowClose:Boolean;
		/**
		 * tip用户数据 
		 */		
		public var userData:Object;
		/**
		 * tip类型 
		 */		
		public var tipClass:Class;
		/**
		 * over 
		 */		
		public var overFun:Function;
		/**
		 * out 
		 */		
		public var outFun:Function;

		/**
		 * 是否显示关闭按钮
		 */	
		public var needShowClose:Boolean;

		/**
		 * 是否制定位置 
		 */	
		public var isPosition:Boolean;
		/**
		 * 位置：x 
		 */		
		public var x:int;
		/**
		 * 位置：y 
		 */		
		public var y:int;
	}
}