package game.client.net.handler.user
{
	public final class UserCmd
	{
		public static const CG_ASK_LOGIN:int = 1000;
		public static const CG_ENTER_SCENE_OK:int = 10004;
		public static const CG_HEART_BEAT:int = 10012;
		public static const CG_MOVE:int = 10007;
		
		public static const GC_ASK_LOGIN:int = 10002;
		public static const GC_ENTER_SCENE:int = 10003;
		public static const GC_HUMAN_INFO:int = 10006;
		public static const GC_ADD_PLAYER:int = 10009;
		public static const GC_MOVE:int = 10008;
		public static const GC_SPEED_CHANGE:int = 10005;
		public static const GC_DETAIL_ATTR:int = 10011;
		public static const GC_DISCONNECT_NOTIFY:int = 10028;
		public static const GC_DEL_ROLE:int = 10010;
		public static const CG_QUERY_PLAYER_INFO:int = 10013;
		public static const GC_PLAYER_INFO:int = 10014;
		public static const GC_EXP_DISPLAY:int = 10016
		public static const GC_JUMP_POINT:int = 10015
		public static const GC_DIRECTION_CHANGE:int = 10019;
		public static const CG_STOP_MOVE:int = 10020;
		public static const GC_STOP_MOVE:int = 10021;
		public static const CG_HUMAN_STATUS_CHANGE:int = 10022;
		public static const GC_HUMAN_STATUS_CHANGE:int = 10023;
		public static const GC_FRIEND_SIT_CHANGE:int = 10024;
		public static const CG_FRIEND_SIT:int = 10025;
		public static const GC_FRIEND_SIT:int = 10026;
		public static const GC_OBJ_DIE:int = 10017;
		public static const GC_LEVEL_UP:int = 10018;
		public static const CG_SYSTEM_CONFIG:int = 10031;
		public static const GC_SYSTEM_CONFIG:int = 10032;
		public static const CG_CHOOSE_CHAR:int = 10098;
		public static const GC_CHOOSE_CHAR:int = 10097;
		public static const CG_HUMAN_QUERY:int = 10029;
		public static const GC_HUMAN_QUERY:int = 10030;
		
		public static const CG_HUMAN_REVIVE:int = 10027;
		public static const GC_HUMAN_REVIVE:int = 10042;
		public static const CG_FIGHTVALUE_GIFT_QUERY:int = 10035;
		public static const GC_FIGHTVALUE_GIFT_QUERY:int = 10036;
		public static const CG_FIGHTVALUE_GIFT_GET:int = 10037;	
		public static const GC_FIGHTVALUE_QUERY:int = 10038
		public static const CG_FIGHTVALUE_QUERY:int = 10039
		public static const CG_FLY:int = 10034;
		public static const CG_ATTACK_MODE:int = 10040;
		public static const GC_ATTACK_MODE:int = 10041;
	}
}