package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankMountListSkin;
	

	public class RankMountList extends RankList
	{
		private static var _instance:RankMountList;
		public static function getInstance():RankMountList
		{
			if(_instance == null)
				_instance = new RankMountList();
			return _instance;
		}
		
		public function RankMountList()
		{
			this.skin = RankMountListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
		}
	}
}