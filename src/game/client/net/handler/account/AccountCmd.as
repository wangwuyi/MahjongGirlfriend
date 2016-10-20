package game.client.net.handler.account
{
	public class AccountCmd
	{
		////检测版本号是否正确
		public static const LP_CHECKEDITION:int = 1000;
		//注册用户
		public static const LP_PLAYER_CREATE:int = 1001;
		//用户登陆
		public static const LP_PLAYER_LOGIN:int = 1002;
		//平台用户登陆
		public static const LP_PLAYER_LOGIN_Plat_Form:int = 1003;
		//进入直播断开后再次登陆
		public static const LP_PLAYER_LOGIN_LIVE:int = 1005;
	}
}