package game.client.module.ui.rank
{
	import game.client.module.BasePanel;
	import game.client.module.ui.rank.skin.RankRolePanelSkin;
	
	public class RankRolePanel extends BasePanel
	{
		private static var _instance:RankRolePanel;
		public static function getInstance():RankRolePanel
		{
			if(_instance == null)
				_instance = new RankRolePanel();
			return _instance;
		}
		
		public function RankRolePanel()
		{
			this.skin = RankRolePanelSkin.skin;
			initView();
		}
		
		private function initView():void
		{
			
		}
	}
}