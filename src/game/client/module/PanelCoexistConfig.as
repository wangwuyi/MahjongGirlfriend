package game.client.module
{
	import flash.utils.Dictionary;

	public class PanelCoexistConfig
	{
		//面板左右共存规则配置表，key为左右面板名字，value为左右面板相粘连面板
		public static var leftDic:Dictionary = new Dictionary();
		public static var rightDic:Dictionary = new Dictionary();
		
		initialize();
		
		private static function initialize():void
		{
			leftDic["RolePanel"] = ["FightvalueGiftPanel"];
			rightDic["FightvalueGiftPanel"] = ["RolePanel"];
			
			leftDic["RolePanel"] = ["IntergralShopPanel"];
			rightDic["IntergralShopPanel"] = ["RolePanel"];
			
			leftDic["RolePanel"] = ["ChestPanel"];
			rightDic["ChestPanel"] = ["RolePanel"];
			
			leftDic["ChestPanel"] = ["AttributeTransferPanel"];
			rightDic["AttributeTransferPanel"] = ["ChestPanel"];
			
			leftDic["BagPanel"] = ["SkillPanel"];
			rightDic["SkillPanel"] = ["BagPanel"];
		}
	}
}