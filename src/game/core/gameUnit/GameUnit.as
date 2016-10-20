package game.core.gameUnit
{
	
	import flash.display.Sprite;
	
	import game.component.ComponentFactory;
	import game.component.core.ISkinnable;
	import game.core.utils.Astar;
	
	public class GameUnit extends Sprite implements ISkinnable
	{
		
		public var id:int;
		
		private var _state:int;
		
		public var startTime:int;
	
		//设定切换场景时是否需要释放资源
		private var _releaseResource:Boolean = true;
		
		/**
		 *新手引导键 
		 */		
		private var _guideKey:String;
		
		public function set state(value:int):void
		{
			_state = value;
		}
		
		public function get state():int
		{
			return _state;
		}
		
		public function show():void
		{
			
		}
		
		public function update(now:int):void
		{
		
		}
		
		public function interaction():void
		{
		
		}
		
		public function onNearThing():void
		{
		
		}
		
		public function algin():void
		{
			var node:Object = Astar.getNode(y / Astar.size, x / Astar.size);
			if (!node)
				return;
			alpha = node.isAlpha ? 0.5 : 1;
		}
		
		public function mouseOver():void
		{
		
		}
		
		public function mouseOut():void
		{
		
		}
		
		public function set releaseResource(value:Boolean):void
		{
			_releaseResource = value;
		}
		
		public function get releaseResource():Boolean
		{
			return _releaseResource;
		}
		
		//池化对象归池之前的属性复位
		public function checkIn():void
		{
			this.visible = true;
			this.alpha = 1;
			this.name = "";
			_state = 1;//在Role中1表示活着
		}
		
		public function dispose():void
		{
			checkIn();
		}
		
		public function get guideKey():String
		{
			return _guideKey;
		}
		
		public function set guideKey(value:String):void
		{
			this._guideKey = value;
			ComponentFactory.registerGuideKey(value,this);
		}
		
		public function set skin(value:Object):void
		{
			// TODO Auto Generated method stub
		}
		
		public function get skin():Object
		{
			// TODO Auto Generated method stub
			return null;
		}
		
	}
}
