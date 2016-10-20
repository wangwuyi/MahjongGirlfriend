package game.client.net
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import game.client.module.popUI.MsgBox;
	import game.client.net.client.AccountClient;
	import game.client.net.client.CreateRoleClient;
	import game.client.net.client.UserClient;
	import game.client.net.handler.account.AccountHandler;
	import game.client.net.handler.common.CommonHandler;
	import game.client.net.handler.createRole.CreateRoleHandler;
	import game.client.net.handler.user.UserHandler;
	import game.core.net.SocketConnection;
	import game.core.utils.Timer;

	public class GameServer extends EventDispatcher implements IEventDispatcher
	{
		private static var gameServer:GameServer = new GameServer();
		private static const HEART_BEAT_TIME_INTERVAL:int = 12000;
		private static var heartBeatLastTime:int = 0;
		
		public function GameServer()
		{
			new CommonHandler();
			new AccountHandler();
		}
		
		public static function getInstance():GameServer
		{
			return gameServer;
		}
		
		public function init():void
		{
			SocketConnection.getInstance().init(onConnect, onClose, onIOError);
			SocketConnection.getInstance().connect(ServerConfig.ip,ServerConfig.port);
		}
		
		public function onConnect():void
		{
//			AccountClient.getInstance().checkEdition("1.0.1", 100001, 1, "PC", "WIFI", "iphone", "0000000000000000000");
			Timer.add(keepHeartBeat);
		}
		
		private function keepHeartBeat(now:int):void
		{
			var isConnected:Boolean = SocketConnection.getInstance().isConnected();
			if(!isConnected)
			{
				return;
			}
			if ((now - heartBeatLastTime) > HEART_BEAT_TIME_INTERVAL)
			{
//				UserClient.getInstance().connectHeartBeat(0);
				heartBeatLastTime = now;
			}
		}
		
		private function onIOError():void
		{
			MsgBox.show("连接服务器出错", MsgBox.YES, onCloseGame, false);
		}
		
		private function onClose():void
		{
			MsgBox.show("与服务器断开", MsgBox.YES, onCloseGame, false);
		}
		
		private function onCloseGame():void
		{
			ServerConfig.goTofficialHome()
		}
	}
}