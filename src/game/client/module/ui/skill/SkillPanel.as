package game.client.module.ui.skill
{
	import flash.events.MouseEvent;
	
	import game.client.module.BasePanel;
	import game.client.module.page.CommonPage;
	import game.client.module.ui.skill.skin.SkillPanelSkin;
	import game.component.Container;
	import game.component.List;
	
	public class SkillPanel extends BasePanel
	{
		public static var instance:SkillPanel = new SkillPanel();
		private var _skillInfo:Container;
		private var _skillList:SkillListContainer;
		
		public function SkillPanel()
		{
			this.closeeffect=true;
			this.skin = SkillPanelSkin.skin;
			init();
		}
		
		private function init():void{
			_skillInfo = getChildByName("skill") as Container;
			var commPage:CommonPage = new CommonPage;
			commPage.config(null, null, null, null, null);
			_skillList = new SkillListContainer(_skillInfo.getChildByName("guildMember") as List, commPage, selectSkill);
			_skillList.setSkill(0);
		}
		
		private function selectSkill(skillVO:Object):void
		{
			
		}
		
	}
}