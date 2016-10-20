package game.client.net.handler.account
{
	import game.core.net.Handler;
	import game.core.utils.Utils;
	
	public class AccountHandler extends Handler
	{
		public function AccountHandler()
		{
			register(AccountCmd.LP_CHECKEDITION, [4], checkEdition);
		}
		
		public static function checkEdition(ip:String):void
		{	
			Utils.log(ip, Utils.LOG_INFO);
		}
	}
}