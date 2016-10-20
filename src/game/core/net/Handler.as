package game.core.net
{
	import flash.errors.EOFError;
	import flash.utils.ByteArray;
	
	import game.core.utils.Utils;

	public class Handler
	{
		public static const TYPE_BYTE:int 	= 1;
		public static const TYPE_SHORT:int 	= 2;
		public static const TYPE_INT:int 	= 3;
		public static const TYPE_STR:int 	= 4;
		
		
		private static var funArr:Array = [];
		private static var decoderArr:Array = [];
		private static var handlerArr:Array = [];
		
		public function Handler()
		{
		}
		
		public static function doMessage(cmd:int,data:ByteArray):void
		{
			Utils.log("doMessage "+cmd, Utils.LOG_INFO);
			var handler:Handler = handlerArr[cmd];
			if(handler != null)
			{
				handler.execute(cmd,data);
			}
			else
			{
				Utils.log("Handler 未注册的协议： " + cmd, Utils.LOG_ERR);
			}
		}
		
		public function register(cmd:int, decode:Array, fun:Function = null):void
		{
			funArr[cmd] = fun;
			decoderArr[cmd] = decode;
			handlerArr[cmd] = this;
		}
		
		public function execute(cmd:int, data:ByteArray):void
		{
			Utils.log("execute "+cmd, Utils.LOG_INFO);
			data.position = 0;
			if (funArr[cmd] == null)
			{
				Utils.log("Fun 未注册的协议： " + cmd, Utils.LOG_ERR);
			}
			else
			{
				var decoder:Array = decoderArr[cmd];
				var param:Array = decode(cmd, decoder, data) as Array;
				Utils.log("Fun G->C: " + cmd);
				var fun:Function = funArr[cmd];
				fun.apply(null, param);
			}
		}
		
		private function decode(cmd:int, decodeObj:Array, data:ByteArray,depth:int = 1):Object
		{
			var result:Array = [];
			var length:int = decodeObj.length;
			try
			{
				for (var i:int = 0; i < length; i++)
				{
					if (decodeObj[i] is Array)
					{
						var len:int = data.readShort();
						var parent:Array = [];
						for (var j:int = 0; j < len; j++)
						{
							parent.push(decode(cmd, decodeObj[i], data,depth + 1));
						}
						result.push(parent); 
					}
					else
					{
						var fn:int = decodeObj[i];
						if (fn == TYPE_BYTE)
						{
							result.push(data.readByte());
						}
						else if (fn == TYPE_SHORT)
						{
							result.push(data.readShort());
						}
						else if (fn == TYPE_INT)
						{
							result.push(data.readInt());
						}
						else if (fn == TYPE_STR)
						{
							result.push(data.readUTF());
						}
					}
				}
			}
			catch (e:EOFError)
			{
				Utils.log("Handler.decode DecodeError: " + cmd, Utils.LOG_ERR);
				throw(e);
			}
			if(depth > 2 && length == 1)
			{
				return result[0]; 
			}
			return result;
		}
	}
}