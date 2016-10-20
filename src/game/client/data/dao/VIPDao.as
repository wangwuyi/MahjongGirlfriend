package game.client.data.dao
{
	import flash.utils.Dictionary;
	
	import game.client.data.dataBase.VipConfig;
	import game.client.utils.HtmlUtil;

	public class VIPDao
	{
		private static var _vipTemplateListCache:Array;
		
		private static const _cardIdList:Array = [216001, 216002, 216003];
		
		public static function getCardName(vipLevel:int):String
		{
			return getVipPreffix(vipLevel) + "VIP";
		}
		
		/**
		 * 获取至尊VIP的首充奖励物品
		 * @return 
		 * 
		 */
		public static function getTopVipGift():Array
		{
			var conf:VipConfig = VipConfig.configData[topLevel];
			var arr:Array = conf.itemList;
			return arr;
		}
		
		/**
		 * 获取VIP最高等级
		 * @return 
		 * 
		 */
		public static function get topLevel():int
		{
			var topLevel:int = 0;
			var conf:VipConfig;
			var dic:Dictionary = VipConfig.configData;
			for each(conf in dic)
			{
				if(conf.vipLv > topLevel)
				{
					topLevel = conf.vipLv;
				}
			}
			return topLevel;
		}
		
		public static function get vipTemplateList():Array
		{
			if(null == _vipTemplateListCache)
			{
				_vipTemplateListCache = [];
				var conf:VipConfig;
				var dic:Dictionary = VipConfig.configData;
				for each(conf in dic)
				{
					if(conf.vipLv > 0)
					{
						_vipTemplateListCache.push(conf);
					}
				}
			}
			return _vipTemplateListCache;
		}
		
		public static function getVipPreffix(level:int):String
		{
			var pref:String;
			switch(level)
			{
				case 1:
					pref = "普通";
					break;
				case 2:
					pref = "高级";
					break;
				case 3:
					pref = "至尊";
					break;
				default:
					pref = "未定义VIP前缀";
					break;
			}
			return pref;
		}
		
	}
}