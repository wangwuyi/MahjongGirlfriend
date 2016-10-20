package game.client.data.dao
{
	import game.client.data.dataBase.AchieveListConfig;
	import game.client.data.dataBase.AchieveMenuConfig;
	import game.client.data.dataBase.AchieveNodeConfig;

	public class AchievementDao
	{
		public function AchievementDao()
		{
		}
		
		public static function getAchievementList():Array
		{
			var achList:Array = [];
			for each(var n:* in AchieveListConfig.configData)
			{
				achList.push(n);
			}
			return achList.sortOn("id", Array.NUMERIC);
		}
		
		public static function getAchievementConfig(id:int):AchieveListConfig
		{
			return AchieveListConfig.configData[id];
		}
		
		public static function getAchievementMenus(type:int):Array
		{
			var achMenus:Array = [];
			for each(var n:* in AchieveMenuConfig.configData)
			{
				if(AchieveMenuConfig(n).pid == type)
					achMenus.push(n);
			}
			return achMenus.sortOn("id", Array.NUMERIC);
		}
		
		public static function getAchievementMenu(id:int):AchieveMenuConfig
		{
			return AchieveMenuConfig.configData[id];
		}
		
		public static function getAchievementNode(id:int):AchieveNodeConfig
		{
			return AchieveNodeConfig.configData[id];
		}
	}
}