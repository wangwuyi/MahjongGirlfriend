package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankPetrealListSkin;

	public class RankPetRealList extends RankList
	{
		private static var _instance:RankPetRealList;
		public static function getInstance():RankPetRealList
		{
			if(_instance == null)
				_instance = new RankPetRealList();
			return _instance;
		}
		
		public function RankPetRealList()
		{
			this.skin = RankPetrealListSkin.skin;
			init();
		}
		
		private function init():void
		{
			
		}
		
		override public function updateSubtype(subtype:int):void
		{
		}
	}
}