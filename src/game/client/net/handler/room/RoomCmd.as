package game.client.net.handler.room
{
	public class RoomCmd
	{
		//进入，退出万人场
		public static const Logic_CB_Join:int = 30001;
		//下注
		public static const Logic_CB_Pour:int = 30002;
		//抢庄，下庄
		public static const Logic_CB_Banker:int = 30003;
		//聊天发言
		public static const Logic_CB_Chat:int = 30004;
		//查看无座玩家（按范围，第几到第几个玩家）
		public static const Logic_CB_Get_Players:int = 30005;
		//聊天推送
		public static const Logic_CB_Chat_Push:int = 30006;
		//金钱不足，强制下庄推送
		public static const Logic_CB_Banker_Down_Push:int = 30007;
		//下注推送
		public static const Logic_CB_Pour_Push:int = 30008;
		//CB流程推送
		public static const Logic_CB_Status_Push:int = 30009;
		//结算推送
		public static const Logic_CB_Over_Push:int = 30010;
		// 获取申请上庄玩家列表
		public static const Logic_CB_Chat:int = 30011;
		//获取顺天地门输赢情况
		public static const Logic_CB_Win_Lost:int = 30012;
		//cb房间红包推送
		public static const Logic_CB_Red_Bag_Push:int = 30013;
		//玩家次饼房间发红包
		public static const Logic_CB_Send_Red_Bag:int = 30014;
		//抢座位
		public static const Logic_CB_Rob:int = 30015;
		//玩家抢座位推送
		public static const Logic_CB_Rob_List_Push:int = 30016;
		//玩家被强制上庄推送
		public static const Logic_CB_Coerce_Push:int = 30017;
	}
}