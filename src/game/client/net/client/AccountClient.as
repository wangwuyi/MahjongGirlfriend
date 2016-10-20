package game.client.net.client
{
	import game.client.manager.SingletonFactory;
	import game.client.net.handler.account.AccountCmd;
	import game.core.net.AbstractClient;
	
	public class AccountClient extends AbstractClient
	{
		public function AccountClient()
		{
			super();
			register(AccountCmd.LP_CHECKEDITION, [4,3,3,4,4,4,4]);
		}
		
		public static function getInstance():AccountClient
		{
			return SingletonFactory.createObject(AccountClient);
		}
		
		public function checkEdition(client_version:String,channel:int,lang:int,os_version:String,network_type:String,termin_info:String,idfa:String):void
		{
			sendMessage(AccountCmd.LP_CHECKEDITION, arguments);
		}
	}
}