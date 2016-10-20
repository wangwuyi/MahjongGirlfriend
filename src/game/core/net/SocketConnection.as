package game.core.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import game.core.utils.Utils;
	
	public class SocketConnection extends EventDispatcher
	{
		private var socket:Socket = new Socket();
		private var connectHandler:Function;
		private var closeHandler:Function;
		private var errorHandler:Function;
		private var recvBuf:ByteArray = new ByteArray();
		private var data:ByteArray = new ByteArray();
		
		private var lastCmd:int = 0;
		private var lastPkgLen:int = 0;
		
		private var curCmd:int = 0;
		private var curPkgLen:int = 0;
		
		public var send:Function;
		
		private static var connection:SocketConnection = new SocketConnection;
		
		public static function getInstance():SocketConnection
		{
			return connection;
		}
		
		public function init(connect:Function, close:Function, error:Function):void
		{
			connectHandler = connect;
			closeHandler = close;
			errorHandler = error;
		}
		
		public function connect(ip:String, port:int):void
		{
			socket.addEventListener(Event.CONNECT, onConnectStateHandler);
			socket.addEventListener(Event.CLOSE, onConnectStateHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
			send = function(cmd:int, body:ByteArray):void
			{
				if (!socket.connected)
					return;
				socket.writeShort(body.length+5);
				socket.writeShort(cmd);
				socket.writeByte(0);
				socket.writeBytes(body);
				socket.flush();
			}
			socket.connect(ip, port);
		}
		
		public function close():void
		{
			if(socket.connected == true)
			{
				socket.close();
			}
		}
		
		public function isConnected():Boolean
		{
			return socket.connected;
		}
		
		private function onSocketDataHandler(e:ProgressEvent):void
		{ 
			var len:int;
			var cmd:int;
			var result:int;
			if (recvBuf.length && recvBuf.length == recvBuf.position)
			{ 
				recvBuf.clear();
			}
			socket.readBytes(recvBuf, recvBuf.length); 
			while (recvBuf.bytesAvailable >= 6)
			{
				len = recvBuf.readShort();
				cmd = recvBuf.readShort();
				recvBuf.readByte();
				result = recvBuf.readByte();
				lastCmd = curCmd;
				curCmd = cmd;
				lastPkgLen = curPkgLen;
				curPkgLen = len;
				data.length = len - 6;
				data.position = 0;
				if(data.length > 0)
				{
					recvBuf.readBytes(data, 0, data.length);
				}
				Handler.doMessage(cmd,data);
			}
		}
		
		private function onConnectStateHandler(e:Event):void
		{
			if (e.type == Event.CONNECT)
			{
				connectHandler();
			}
			else if (e.type == Event.CLOSE)
			{
				closeHandler();
			}
		}
		
		private function onErrorHandler(e:IOErrorEvent):void
		{
			if(errorHandler != null)
			{
				errorHandler();
			}
			Utils.log("IOErrorEvent:"+e.text, Utils.LOG_ERR);
			Utils.log("lastCmd: "+lastCmd+" len:"+lastPkgLen, Utils.LOG_ERR);
			Utils.log("curCmd: "+curCmd+" len:"+curPkgLen, Utils.LOG_ERR);
		}
		
		private  function onSecurityErrorHandler(e:SecurityErrorEvent):void
		{
			Utils.log("SecurityErrorEvent:"+e.text, Utils.LOG_ERR);
		}
		
	}
}