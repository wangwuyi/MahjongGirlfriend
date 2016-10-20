package game.client.net.handler.createRole
{
	import game.core.net.Handler;

	public class CreateRoleHandler extends Handler
	{
		public function CreateRoleHandler()
		{
			register(CreateRoleCmd.GC_ENTER_SCENE, [0,1,0,3,1,1,3,0,0,3], enterScene);
			register(CreateRoleCmd.GC_ASK_LOGIN, [0,2,2,1], askLogin);
			register(CreateRoleCmd.GC_CHOOSE_CHAR, [0], chooseChar);
		}
		
		/**
		 result:1  //进入场景结果
		 objid:1  //对象ID
		 mapid:1  //地图id
		 maptype:1  //地图类型
		 scenex:1  //场景x坐标
		 sceney:1  //场景y坐标
		 mode:1  //白天/黑夜模式
		 mapWidth:1  //
		 mapHeight:1  //
		 isJump:1  //
		 */
		public static function enterScene(result:int,objid:int,mapid:int,maptype:int,scenex:int,sceney:int,mode:int,mapWidth:int,mapHeight:int,isJump:int):void
		{	
			
		}
		
		/**
		 result:1  //选角返回
		 */
		public function chooseChar(result:int):void 
		{
			
		}

		
		/**
		 result:1  //登录结果
		 svrName:32  //游戏服务器名称
		 msvrIP:32  //跨服pk服ip
		 msvrPort:1  //跨服pk服port
		 */
		public function askLogin(result:int,svrName:String,msvrIP:String,msvrPort:int):void 
		{
			
		}
		
	}
}