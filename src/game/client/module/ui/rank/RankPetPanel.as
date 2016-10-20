package game.client.module.ui.rank
{
	import game.client.module.BasePanel;
	import game.client.module.ui.rank.skin.RankPetPanelSkin;
	
	public class RankPetPanel extends BasePanel
	{
		private static var _instance:RankPetPanel;
		public static function getInstance():RankPetPanel
		{
			if(_instance == null)
				_instance = new RankPetPanel();
			return _instance;
		}
		
		public function RankPetPanel()
		{
			this.skin = RankPetPanelSkin.skin;
			initView();
		}
		
		private function initView():void
		{
			
		}
	}
}