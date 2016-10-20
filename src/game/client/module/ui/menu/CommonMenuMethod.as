package game.client.module.ui.menu
{
	import flash.system.System;
	
	import game.client.model.GlobalModel;

	public class CommonMenuMethod
	{
		public static function chat(name:String):void
		{
			//UserClient.getInstance().humanQuery(name,GlobalModel.HUAME_PRIVATE_CHAT);
		}
		
		public static function addFriend(name:String):void
		{
			//FriendClient.getInstance().cgRelatoinUpdate(name, FriendClient.RELATION_UPDATE_OP_APPLY, FriendClient.RELATION_UPDATE_TYPE_FRIEND);
		}
		
		public static function inviteTrade(name:String):void
		{
			//TradeClient.getInstance().dealApply(name);
		}
		
		public static function copyName(name:String):void
		{
			System.setClipboard(name);
		}
		
		public static function sendEmail(name:String,title:String=""):void
		{
			//MailPanel.instance.write(name, title)
		}
		
		public static function inviteTeam(name:String):void
		{
			//TeamClient.getInstance().teamInvite(name,TeamConstant.NORMAL_TEAM);
		}
		
		public static function deliverFlower(name:String):void
		{
			//PresentFlowerPanel.instance.sendToUser(name);
		}
		
		public static function achievementCompare(name:String):void
		{
			//AchievementClient.getInstance().achievementCompare(name);
		}
	}
}