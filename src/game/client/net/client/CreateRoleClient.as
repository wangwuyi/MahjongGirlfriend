package game.client.net.client
{
	import game.client.manager.SingletonFactory;
	import game.client.net.handler.createRole.CreateRoleCmd;
	import game.core.net.AbstractClient;

	public class CreateRoleClient  extends AbstractClient
	{
		public function CreateRoleClient()
		{
			super();
			register(CreateRoleCmd.CG_ENTER_SCENE_OK, [3]);
			register(CreateRoleCmd.CG_ASK_LOGIN, [2,2,2,1,0,1]);
			register(CreateRoleCmd.CG_CHOOSE_CHAR, [0,2]);
		}
		
		public static function getInstance():CreateRoleClient
		{
			return SingletonFactory.createObject(CreateRoleClient);
		}
		
		public function enterSceneOk(isFirstEnter:int):void
		{
			sendMessage(CreateRoleCmd.CG_ENTER_SCENE_OK, arguments);
		}
		
		
		/**
		 svrName:32  //服务器名
		 account:32  //帐号
		 authkey:128  //校验key
		 timestamp:1  //时间戳
		 status:1  // 防沉迷状态[未填,未通过,已通过]
		 cityNum:1  //城市号--后台传过来的
		 */
		public function askLogin(svrName:String,account:String,authkey:String,timestamp:int,status:int,cityNum:int):void 
		{
			sendMessage(CreateRoleCmd.CG_ASK_LOGIN, arguments);
		}
		
		/**
		 job:1  //职业
		 roleName:32  //角色名
		 */
		public function chooseChar(job:int,roleName:String):void {
			sendMessage(CreateRoleCmd.CG_CHOOSE_CHAR, arguments);
		}
		
		
	}
}