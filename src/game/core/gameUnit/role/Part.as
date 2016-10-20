package game.core.gameUnit.role
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import game.core.manager.ResourceManager;
	
	public class Part extends Bitmap
	{
		public var type:int;
		
		public var isHide:Boolean;
		private var _url:String;
		private var _priority:int;
		
		/**
		 *武器和身体的深度 
		 */		
		public static var layer:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1];
		
		public function Part(type:int, name:String, priority:int)
		{
			this.type = type;
			this.name = name;
			_priority = priority;
		}
		
		public function set url(value:String):void
		{
			if(_url != value && _url != null && _url != "")
			{
				ResourceManager.decreaseResourceReference(_url);	
			}
			if(value != _url && value != "" && value != null)
			{
				ResourceManager.increaseResourceReference(value);
			}
			_url = value;
		}
		
		public function set priority(value:int):void
		{
			_priority = value;
		}
		
		public function get priority():int
		{
			return _priority;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function dispose():void
		{
			this.x = 0;
			this.y = 0;
			this.bitmapData = null;
			this.url = null;
		}
		
	}
}
