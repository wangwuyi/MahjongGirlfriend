package game.client.module.ui.rank.list
{
	import game.client.module.ui.rank.skin.RankIntersectionListSkin;
	
	public class RankIntersectionList extends RankList
	{
		private static var _instance:RankIntersectionList;
		public static function getInstance():RankIntersectionList
		{
			if(_instance == null)
				_instance = new RankIntersectionList();
			return _instance;
		}
		
		public function RankIntersectionList()
		{
			this.skin = RankIntersectionListSkin.skin;
		}
		
		override public function updateSubtype(subtype:int):void
		{
			// TODO Auto Generated method stub
			super.updateSubtype(subtype);
		}
	}
}