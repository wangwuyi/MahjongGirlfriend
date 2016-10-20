package game.client.net.handler.character
{
	public class CharacterCmd
	{
		//客户端第一次连接到GameServer之前做连接验证，包括Session close之后的重连
		public static const Logic_LOGIN_PLAYERCHECK:int = 10000;
		//创建角色
		public static const Logic_LOGIN_ACTORCREATE:int = 10002;
		//跑马灯消息推送
		public static const Logic_System_Marquee:int = 10034;
		//用户角色登入GameServer（即进入游戏
		public static const Logic_LOGIN_ACTORENTER:int = 10001;
		// 心跳消息
		public static const Core_SYSTEM_HEART:int = 1;
		// 签到
		public static const Logic_LOGIN_SIGN:int = 12000;
		//获取邮件列表
		public static const Logic_Mail_Get:int = 13101;
		//获取邮件奖励
		public static const Logic_Mail_Reward:int = 13102;
		//发送邮件
		public static const Logic_Mail_Send:int = 13103;
		//发送红包
		public static const Logic_Chat_Send_Red_Packet:int = 10027;
		//查看红包
		public static const Logic_check_Red_Packet:int = 10028;
		//用户反馈
		public static const Logic_User_Feedback:int = 10029;
		//主播开播推送
		public static const Logic_Push_Live_Open:int = 10030;
		// 填写推荐人
		public static const Logic_Login_Referrer:int = 12001;
		// 新手引导进度记录
		public static const Logic_Guide_Point:int = 10033;
		//获取聊天服务器
		public static const Logic_Get_Chat_Server:int = 10037;
		// 每日转盘列表
		public static const Logic_Lucky_Dial_List:int = 20007;
		// 玩家线下活动数据登记
		public static const Logic_Offline_Meeting:int = 10049;
		// 修改角色名
		public static const Logic_Change_Actor_Name:int = 10053;
		// 获取改名需要的彩钻数量
		public static const Logic_Get_Change_Actor_Name_Need_Money:int = 10054;
		// 获取跑马灯记录列表
		public static const Logic_Marquee_List:int = 10058;
		// 发送跑马灯
		public static const Logic_Send_Marqiee:int = 10059;
		// 发送跑马灯需要的金钱或道具类型
		public static const Logic_Send_Marqiee_Need:int = 10060;
	}
}