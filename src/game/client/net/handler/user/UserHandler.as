package game.client.net.handler.user
{
	import game.client.module.ui.broadcast.Alert;
	import game.core.net.Handler;
	
	public class UserHandler extends Handler
	{
		public function UserHandler()
		{
//			register(UserCmd.GC_HUMAN_INFO, [2,0,3,1,0,3,3,1,1,0,3,1,1,3,0,0,0,2,0,1,3], humanInfo);
		}
		
		public static function returnCode(id:int,showWay:int,retCode:int,content:String):void
		{
			Alert.show(content, Alert.RIGHT_DOWN);
		}
		
	}
}