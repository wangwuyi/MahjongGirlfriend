package game.client.module.ui.systemtip
{
	public class Message
	{
		private static var _pool:Array = []
		
		private var _contentStr:String;
		private var _color:String;
		
		public static function instance():Message
		{
			return _pool.length? _pool.pop():new Message;
		}
		
		public function set contentStr(value:String):void
		{
			this._contentStr = value;
		}
		
		public function get contentStr():String
		{
			return _contentStr;
		}
		
		public function set color(value:String):void
		{
			this._color = value;
		}
		
		public function get color():String
		{
			return _color;
		}
		
		public function dispose():void
		{
			_pool.push(this);
			_contentStr = "";
			_color = "";
		}
	}
}