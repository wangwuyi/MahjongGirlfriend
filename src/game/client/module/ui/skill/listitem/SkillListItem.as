package game.client.module.ui.skill.listitem
{
	import game.component.Button;
	import game.component.Label;
	import game.component.ListItemBase;
	
	public class SkillListItem extends ListItemBase
	{
		
		private var _upgradeBtn:Button;
		private var _skillNameTxt:Label;
		private var _skillLevelTxt:Label;
		private var _skillTypeTxt:Label;
		
		public static var itemPool:Vector.<SkillListItem> = new Vector.<SkillListItem>();
		
		public static function getInstance():SkillListItem
		{
			return itemPool.length? itemPool.pop():new SkillListItem();
		}
		
		public function SkillListItem()
		{
			super();
		}
		
		override protected function configChildren():void
		{
			super.configChildren();
			_skillNameTxt = getChildByName("txthuofeng") as Label
			_skillLevelTxt = getChildByName("txtshuzi") as Label;
			_skillTypeTxt = getChildByName("txtdang") as Label;
			_skillLevelTxt.width = 26;
			var index:int = this.getChildIndex(_skillNameTxt);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			setData();
		}
		
		private function setData():void
		{
			_skillNameTxt.text = "技能名";
			_skillLevelTxt.text = "5";
		}
	}
}