package game.core.net
{
	import flash.utils.ByteArray;
	
	import game.core.utils.Utils;

	public class AbstractClient
	{
		
		private static var decoderArr:Array = [];
		
		public var bytebuff:ByteArray = new ByteArray();
		
		private var connection:SocketConnection = SocketConnection.getInstance();
		
		public function AbstractClient()
		{
		}
		
		protected function register(cmd:int, decode:Array):void
		{
			decoderArr[cmd] = decode;
		}
		
		public function sendMessage(messageType:int, data:Array):void
		{
			bytebuff.clear();
			var encodeObj:Array = decoderArr[messageType];
			for (var i:int = 0; i < encodeObj.length; i++)
			{
				encode(encodeObj[i], data[i]);
			}
			Utils.log("MessageManager C->G: " + messageType);
			connection.send(messageType, bytebuff);
		}
		
		public function encode(encodeObj:Object, data:Object):ByteArray
		{
			if (encodeObj is Array)
			{
				bytebuff.writeShort(data.length);
				for (var i:int = 0; i < data.length; i++)
				{
					for (var j:int = 0; j < encodeObj.length; j++)
					{
						encode(encodeObj[j], data[i] is Array ? data[i][j] : data[i]);
					}
				}
			}
			else
			{
				if (encodeObj == Handler.TYPE_BYTE)
				{
					bytebuff.writeByte(int(data))
				}
				else if (encodeObj == Handler.TYPE_SHORT)
				{
					bytebuff.writeShort(int(data))
				}
				else if (encodeObj == Handler.TYPE_INT)
				{
					bytebuff.writeInt(int(data))
				}
				else if (encodeObj == Handler.TYPE_STR)
				{
					bytebuff.writeUTF(String(data))
				}
			}
			return bytebuff;
		}
	}
}