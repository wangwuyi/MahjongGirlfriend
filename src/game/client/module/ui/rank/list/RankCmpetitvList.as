package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankCmpetitvListSkin;
	
	public class RankCmpetitvList extends RankList
	{
		private static var _instance:RankCmpetitvList;
		public static function getInstance():RankCmpetitvList
		{
			if(_instance == null)
				_instance = new RankCmpetitvList();
			return _instance;
		}
		
		public function RankCmpetitvList()
		{
			this.skin = RankCmpetitvListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
			// TODO Auto Generated method stub
			super.updateSubtype(subtype);
		}
	}
}