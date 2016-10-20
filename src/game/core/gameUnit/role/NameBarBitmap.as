package game.core.gameUnit.role
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import game.core.manager.ResourceManager;
	
	internal class NameBarBitmap extends Bitmap
	{
		public static const EVT_CONSTRUCTED:String = "constructed";
		private static var _pool:Array = new Array();
		
		public static function getInstance():NameBarBitmap
		{
			if(_pool.length > 0)
			{
				return _pool.shift();
			}
			return new NameBarBitmap();
		}
		
		private var _priority:int;
		private var _url:String;
		
		public function NameBarBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}
		
		public override function set bitmapData(value:BitmapData):void
		{
			super.bitmapData = value;
			if(value != null)
			{
				dispatchEvent(new Event(EVT_CONSTRUCTED));
			}
		}
		
		public function set priority(value:int):void
		{
			_priority = value;
		}
		
		public function get priority():int
		{
			return _priority;
		}
		
		public function set url(value:String):void
		{
			_url = value;
			if(_url != null)
			{
				ResourceManager.getBitmap(this, _url);
			}
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function dispose():void
		{
			ResourceManager.delImageUrlObj(_url,this);
			this.bitmapData = null;
			_url = "";
			_priority = 0;
			_pool.push(this);
		}
	}
}