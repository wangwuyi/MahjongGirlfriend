package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankArenaListSkin;
	
	public class RankArenaList extends RankList
	{
		private static var _instance:RankArenaList;
		public static function getInstance():RankArenaList
		{
			if(_instance == null)
				_instance = new RankArenaList();
			return _instance;
		}
		
		public function RankArenaList()
		{
			this.skin = RankArenaListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
			// TODO Auto Generated method stub
			super.updateSubtype(subtype);
		}
		
	}
}