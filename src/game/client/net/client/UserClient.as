package game.client.net.client
{
	import flash.utils.getTimer;
	
	import game.client.manager.SingletonFactory;
	import game.client.net.handler.user.UserCmd;
	import game.core.net.AbstractClient;
	
	public class UserClient extends AbstractClient
	{
		public function UserClient()
		{
			super();
			register(UserCmd.CG_ASK_LOGIN, [2,1,1,2,2,2,2]);
			register(UserCmd.CG_FRIEND_SIT, [2]);
			register(UserCmd.CG_QUERY_PLAYER_INFO, [2]);
//			register(UserCmd.CG_ENTER_SCENE_OK, [3]);
			register(UserCmd.CG_HEART_BEAT, []);
			register(UserCmd.CG_MOVE, [0,[0,0]]);
			register(UserCmd.CG_SYSTEM_CONFIG, [0,0,0,1,1]);
			register(UserCmd.CG_HUMAN_QUERY, [2,3]);
			register(UserCmd.CG_HUMAN_STATUS_CHANGE, [3,1]);
			register(UserCmd.CG_STOP_MOVE, [0,0]);
			register(UserCmd.CG_HUMAN_REVIVE, [3]);
			register(UserCmd.CG_FIGHTVALUE_GIFT_QUERY, []);
			register(UserCmd.CG_FIGHTVALUE_GIFT_GET, []);
			register(UserCmd.CG_FIGHTVALUE_QUERY, []);
			register(UserCmd.CG_FLY, [1,1,1,1]);
			register(UserCmd.CG_ATTACK_MODE, [3]);
		}
		
		public static function getInstance():UserClient
		{
			return SingletonFactory.createObject(UserClient);
		}
		
		public function askLogin(client_version:String,channel:int,lang:int,os_version:String,network_type:String,termin_info:String,idfa:String):void
		{
			sendMessage(UserCmd.CG_ASK_LOGIN, arguments);
		}
		
//		public function enterSceneOk(isFirstEnter:int):void
//		{
//			sendMessage(UserCmd.CG_ENTER_SCENE_OK, arguments);
//		}
		
		public function askChangeScene(mapid:int):void
		{
//			sendMessage(UserCmd.CG_ASK_CHANGE_SCENE, arguments);
		}
		
		public function connectHeartBeat(noUse:int):void
		{
			sendMessage(UserCmd.CG_HEART_BEAT, arguments);
		}
		
		public function sendMovePathToGameServer(isJump:int,points:Array):void
		{
			sendMessage(UserCmd.CG_MOVE, arguments);
		}
		
		public function stopMove(x:int,y:int):void
		{
			sendMessage(UserCmd.CG_STOP_MOVE, arguments);
		}
		
		public function queryPlayerInfo(name:String):void
		{
			sendMessage(UserCmd.CG_QUERY_PLAYER_INFO, arguments);
		}
		
		/**
		 newStatus:1  //
		 horseIndex:1  //
		 */
		public function humanStatusChange(newStatus:int,horseIndex:int):void 
		{
			sendMessage(UserCmd.CG_HUMAN_STATUS_CHANGE, arguments);
		}
		
		/**
		 name:64  //请求和某人双休
		 */
		public function friendSit(name:String):void 
		{
			sendMessage(UserCmd.CG_FRIEND_SIT, arguments);
		}
		
		/**
		 equipEffect:1  //屏蔽装备特效
		 pet:1  //屏蔽玩家宠物
		 sceneEffect:1  //屏蔽场景特效
		 backMusic:1  //背景音乐
		 gameMusic:1  //背景音乐
		 */
		public function systemConfig(equipEffect:int,pet:int,sceneEffect:int,backMusic:int,gameMusic:int):void 
		{
			sendMessage(UserCmd.CG_SYSTEM_CONFIG, arguments);
		}
		
		/**
		 name:32  //玩家名
		 op:1  //操作码1普通2好友3...
		 */
		public function humanQuery(name:String,op:int):void
		{
			sendMessage(UserCmd.CG_HUMAN_QUERY, arguments);
		}
		
		/**
		 index:1  //地图配置复活方式的下标，0开始
		 */
		public function humanRevive(index:int):void {
			sendMessage(UserCmd.CG_HUMAN_REVIVE, arguments);
		}
		
		/**
		 */
		public function fightvalueGiftQuery():void {
			sendMessage(UserCmd.CG_FIGHTVALUE_GIFT_QUERY, arguments);
		}
		
		/**
		 */
		public function fightvalueGiftGet():void {
			sendMessage(UserCmd.CG_FIGHTVALUE_GIFT_GET, arguments);
		}
		/**
		 */
		public function fightvalueQuery():void {
			sendMessage(UserCmd.CG_FIGHTVALUE_QUERY, arguments);
		}

		
		/**
		 mapId:1  //目标地图ID
		 posX:1  //目标点X坐标
		 posY:1  //目标点Y坐标
		 npcId:1  //目标NPCID
		 */
		public function fly(mapId:int,posX:int,posY:int,npcId:int):void 
		{
			sendMessage(UserCmd.CG_FLY, arguments);
		}
		
		/**
		 atkMode:1  //1和平 2全体
		 */
		public function attackMode(atkMode:int):void 
		{
			sendMessage(UserCmd.CG_ATTACK_MODE, arguments);
		}
	}
}