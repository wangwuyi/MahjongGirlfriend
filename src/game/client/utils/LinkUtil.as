package game.client.utils
{
	import game.client.module.ui.bag.BagPanel;
	import game.client.module.ui.friend.FriendPanel;
	import game.client.module.ui.rank.RankPanel;
	import game.client.module.ui.skill.SkillPanel;

	public class LinkUtil
	{
		/**链接背包*/		
		public static function linkBag():void
		{
			BagPanel.instance.panelEntry();	
		}
		/**链接技能*/		
		public static function linkSkill():void
		{
			SkillPanel.instance.panelEntry();
		}
		/**链接好友*/		
		public static function linkFriend():void
		{
			FriendPanel.instance.panelEntry();
		}
		/**链接排名*/		
		public static function linkRank():void
		{
			RankPanel.instance.panelEntry();
		}
		
	}
}