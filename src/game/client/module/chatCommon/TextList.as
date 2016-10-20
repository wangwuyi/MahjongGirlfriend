package game.client.module.chatCommon
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TextList extends Sprite
	{
		
		public static const TEXT_NUM_MAX:int = 20;
		private var list:Array = [];
		private var _data:Array;
		private var _height:int;
		
		public function TextList()
		{
			var text:RichText
			for (var j:int = 0; j < TEXT_NUM_MAX; j++)
			{
				text = new RichText();
				text.width = 302;
				list.push(text);
				addChild(text);
			}
		}
		
		public function set data(value:Array):void
		{
			_data = value;
			clearText();
			updateText();
			align()
		}
		
		private function clearText():void
		{
			for(var i:int = 0; i < TEXT_NUM_MAX; i++)
			{
				var text:RichText = list[i];
				text.htmlText = "";
			}
		}
		
		private function updateText():void
		{
			var len:int = _data.length;
			for(var i:int = 0; i < len; i++)
			{
				var text:RichText = list[i];
				text.htmlText = _data[i];
			}
		}
		
		public function get data():Array
		{
			return _data;
		}
		
		private function align():void
		{
			height = 0;
			var text:RichText;
			var len:int = _data.length;
			for (var i:int = 0; i < len; i++)
			{
				var txt:String = _data[i];
				var start:int = 0;
				var result:String = txt;
				text = list[i]
				text.y = height;
				height += text.height;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public override function set height(value:Number):void
		{
			_height = value;
		}
		
		public override function get height():Number
		{
			return _height;
		}
		
		public override function get width():Number
		{
			return 302;
		}
		
		public function set textWidth(value:Number):void
		{
			var len:int = list.length;
			for(var i:int = 0; i < len; i++)
			{
				var text:RichText = list[i];
				text.width = value;
			}
		}
	
	}
}
