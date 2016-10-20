package game.client.net.handler.createRole
{
	public  final class CreateRoleCmd
	{
		public static const CG_ASK_LOGIN:int = 10001;
		public static const CG_ENTER_SCENE_OK:int = 10004;
		
		public static const GC_ASK_LOGIN:int = 10002;
		public static const GC_ENTER_SCENE:int = 10003;
		public static const GC_SPEED_CHANGE:int = 10005;
		public static const CG_CHOOSE_CHAR:int = 10098
		public static const GC_CHOOSE_CHAR:int = 10097
		
		public static const ASK_LOGIN_OK:int = 1;
		public static const ASK_LOGIN_ERROR_CREATECHAR:int = 2;
		public static const ASK_LOGIN_GO_TO_MSVR:int = 3;
		public static const ASK_LOGIN_SERVER_FULL:int = 4;
		public static const ASK_LOGIN_FAIL:int = 5;
		public static const ASK_LOGIN_TIMEOUT:int = 6;
		public static const ASK_LOGIN_NO_CHAR:int = 7;
		public static const ASK_LOGIN_NAME_EXIST:int = 8;
		
		public static const CHOOSE_OK:int = 1 ;
		public static const NO_JOB:int = 2;
		public static const NAME_EXIST:int = 3;
		
		
	}
}